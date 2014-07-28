require File.expand_path '../spec_helper.rb', __FILE__

describe "Slugger class" do
  describe "when created" do
    before do
      @slugger = Slugger.new
    end

    it "loads the players hash" do
      assert @slugger.players.is_a?(Hash)
      assert @slugger.players.keys.count > 0
    end

    it "loads the batting stats array" do
      assert @slugger.batting_stats.is_a?(Array)
      assert @slugger.batting_stats.count > 0
    end
  end

  describe "batter_with_most_improved_batting_average" do
    before do
      players_file = File.expand_path '../data/players.csv', __FILE__
      stats_file = File.expand_path '../data/stats.csv', __FILE__
      @slugger = Slugger.new(players_file, stats_file)
    end

    it "successfully returns the right player" do
      assert_equal "aaronto01", @slugger.batter_with_most_improved_batting_average(2007, 2008).player_id
    end
  end

  describe "team_player_slugging_percentages_for_year" do
    before do
      players_file = File.expand_path '../data/players.csv', __FILE__
      stats_file = File.expand_path '../data/stats.csv', __FILE__
      @slugger = Slugger.new(players_file, stats_file)
    end

    describe "for a valid year/team combo" do
      it "returns a nested array of players and percentages" do
        team_slugging = @slugger.team_player_slugging_percentages_for_year("HOU", 2012)
        assert_equal team_slugging.count, 2
        assert team_slugging.include?([@slugger.players["aaronha01"], 0])
      end
    end

    describe "for an invalid year/team combo" do
      it "returns an empty array" do
        team_slugging = @slugger.team_player_slugging_percentages_for_year("HOU", 2016)
        assert_equal team_slugging, []
      end
    end

  end

  describe "top_player_in_category_for_year" do
    before do
      players_file = File.expand_path '../data/players.csv', __FILE__
      stats_file = File.expand_path '../data/stats.csv', __FILE__
      @slugger = Slugger.new(players_file, stats_file)
    end

    describe "with a valid category and sufficient at-bats" do
      it "returns the correct person id" do
        assert_equal "abadijo01", @slugger.top_player_in_category_for_year(2008, :home_runs, 10)
        assert_equal "aaronto01", @slugger.top_player_in_category_for_year(2008, :at_bats, 10)
      end
    end
    describe "with a valid category but insufficient at-bats" do
      it "returns nil" do
        assert_nil @slugger.top_player_in_category_for_year(2008, :home_runs, 1000)
        assert_nil @slugger.top_player_in_category_for_year(2008, :at_bats, 1000)
      end
    end
    describe "with an invalid category" do
      it "returns nil" do
        assert_nil @slugger.top_player_in_category_for_year(2008, :not_a_valid_category, 50)
      end
    end
  end
end
