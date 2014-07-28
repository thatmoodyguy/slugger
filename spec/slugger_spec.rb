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
end
