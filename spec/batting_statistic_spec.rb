require File.expand_path '../spec_helper.rb', __FILE__

describe "BattingStatistic class" do
  describe "when initialized with a CSV row" do
    before do
      headers = ["playerID","yearID","league","teamID","G","AB","R","H","2B","3B","HR","RBI","SB","CS"]
      @row = CSV::Row.new(headers, ["abercre01",2008,"NL","HOU",34,55,10,17,5,0,2,5,5,2])
    end

    it "should set the attributes properly" do
      stat = BattingStatistic.new(@row)
      assert_equal stat.player_id, "abercre01"
      assert_equal stat.year, 2008
      assert_equal stat.league, "NL"
      assert_equal stat.team_id, "HOU"
      assert_equal stat.at_bats, 55
      assert_equal stat.runs, 10
      assert_equal stat.hits, 17
      assert_equal stat.doubles, 5
      assert_equal stat.triples, 0
      assert_equal stat.home_runs, 2
      assert_equal stat.rbi, 5
    end
  end

  describe "load_from_data_file" do
    before do
      file = File.expand_path '../data/stats.csv', __FILE__
      @stats = BattingStatistic.load_from_data_file(file)
    end

    it "should have the proper number of items" do
      assert_equal @stats.count, 10
    end

  end

  describe "stats_for_player_and_year" do
    before do
      file = File.expand_path '../data/stats.csv', __FILE__
      @stats = BattingStatistic.load_from_data_file(file)
    end

    describe "when a player has played for only one team in that year" do
      it "should return a hash of statistics with the stats" do
        result = BattingStatistic.stats_for_player_and_year(@stats, "aasedo01", 2010)
        assert_equal result[:teams], ["HOU"]
        assert_equal result[:at_bats], 1
      end
      it "should include the batting average and slugging percentage" do
        result = BattingStatistic.stats_for_player_and_year(@stats, "aasedo01", 2010)
        assert !result[:batting_average].nil?
        assert !result[:slugging_percentage].nil?
      end
    end
    describe "when a player has played for multiple teams that year" do
      it "should return an hash of combined stats" do
        result = BattingStatistic.stats_for_player_and_year(@stats, "abadijo01", 2008)
        assert_equal result[:teams].count, 2
        assert result[:teams].include?("HOU")
        assert result[:teams].include?("FLO")
        assert_equal result[:at_bats], 131
        assert_equal result[:hits], 32
        assert_equal result[:doubles], 8
        assert_equal result[:triples], 0
        assert_equal result[:home_runs], 4
        assert_equal result[:rbi], 10
        assert_equal result[:batting_average].round(3), 0.244
        assert_equal result[:slugging_percentage].round(3), 0.397
      end
    end
    describe "when no data is available for that player/year combo" do
      it "should return a hash with empty values" do
        result = BattingStatistic.stats_for_player_and_year(@stats, "notaplayer", 2008)
        assert_equal result[:teams], []
        assert_equal result[:at_bats], 0
      end
    end
  end

  describe "stats_for_all_players_on_team_in_year" do
    before do
      file = File.expand_path '../data/stats.csv', __FILE__
      @stats = BattingStatistic.load_from_data_file(file)
    end

    describe "when one or more players have played for a team that year" do
      it "should return a hash of player_ids with statistics" do
        result = BattingStatistic.stats_for_all_players_on_team_in_year(@stats, "HOU", 2012)
        assert_equal result.keys.count, 2
      end
    end

    describe "when no data is available for that team/year combo" do
      it "should return a hash with empty values" do
        result = BattingStatistic.stats_for_all_players_on_team_in_year(@stats, "SEA", 2016)
        assert_equal result, {}
      end
    end
  end

  describe "player_ids_on_team_for_year" do
    before do
      file = File.expand_path '../data/stats.csv', __FILE__
      @stats = BattingStatistic.load_from_data_file(file)
    end

    describe "when one or more matches is found" do
      it "returns an array of player_ids" do
        assert_equal BattingStatistic.player_ids_on_team_for_year(@stats, "HOU", 2012).count, 2
        assert_equal BattingStatistic.player_ids_on_team_for_year(@stats, "FLO", 2008), ["abadijo01"]
      end
    end

    describe "when no matches are found" do
      it "returns an empty array" do
        assert_equal BattingStatistic.player_ids_on_team_for_year(@stats, "HOU", 2016), []
      end
    end
  end
end
