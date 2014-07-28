require File.expand_path '../spec_helper.rb', __FILE__
require File.expand_path '../../lib/player', __FILE__

describe "Player class" do
  describe "when initialized with a CSV row" do
    before do
      headers = ["playerID","birthYear","nameFirst","nameLast"]
      @row = CSV::Row.new(headers, ["aaronha01",1934,"Hank","Aaron"])
    end

    it "should set the attributes properly" do
      player = Player.new(@row)
      assert_equal player.player_id, "aaronha01"
      assert_equal player.birth_year, 1934
      assert_equal player.first_name, "Hank"
      assert_equal player.last_name, "Aaron"
    end
  end
end
