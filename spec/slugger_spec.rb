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

end
