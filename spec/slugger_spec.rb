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

end
