require File.expand_path '../spec_helper.rb', __FILE__

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

  describe "load_from_data_file" do
    describe "with a well-formed CSV source file" do
      before do
        file = File.expand_path '../data/players.csv', __FILE__
        @players = Player.load_from_data_file(file)
      end

      it "should have the proper number of items" do
        assert_equal @players.keys.count, 5
      end

      it "should be accessible by player ID" do
        assert_equal @players["abadan01"].first_name, "Andy"
        assert_equal @players["abadan01"].last_name, "Abad"
      end
    end

    describe "with a CSV file with missing player ID's" do
      before do
        file = File.expand_path '../data/players_malformed.csv', __FILE__
        @players = Player.load_from_data_file(file)
      end

      it "should have the number of items matching the properly-formed rows" do
        assert_equal @players.keys.count, 4
      end

      it "should be accessible by player ID" do
        assert_equal @players["abadan01"].first_name, "Andy"
        assert_equal @players["abadan01"].last_name, "Abad"
      end
    end

  end
end
