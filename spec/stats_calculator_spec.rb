require File.expand_path '../spec_helper.rb', __FILE__
require File.expand_path '../../lib/stats_calculator', __FILE__

describe "StatsCalculator class" do
  describe "batting_average" do
    describe "when at_bats is greater than zero" do
      before do
        @at_bats = 100
        @hits = 13
      end

      it "should return the proper value" do
        assert_equal 0.13, StatsCalculator.batting_average(@hits, @at_bats)
      end
    end

    describe "when at_bats is zero" do
      before do
        @at_bats = 0
        @hits = 0
      end

      it "should return a zero batting average" do
        assert_equal 0, StatsCalculator.batting_average(@hits, @at_bats)
      end
    end

    describe "when hits is less than zero" do
      before do
        @at_bats = 50
        @hits = -1
      end

      it "should return a zero batting average" do
        assert_equal 0, StatsCalculator.batting_average(@hits, @at_bats)
      end
    end

  end

end
