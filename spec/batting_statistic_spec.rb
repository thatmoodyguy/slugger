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
end
