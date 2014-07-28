require File.expand_path '../spec_helper.rb', __FILE__

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

  describe "slugging_percentage" do
    describe "when all values are valid" do
      before do
        @hits = 20
        @doubles = 5
        @triples = 1
        @home_runs = 3
        @at_bats = 75
      end

      it "should properly calculate the value" do
        assert_equal 0.48, StatsCalculator.slugging_percentage(@hits, @doubles, @triples, @home_runs, @at_bats)
      end
    end

    describe "when hits is less than total of doubles, triples, and HRs" do
      before do
        @hits = 7
        @doubles = 5
        @triples = 1
        @home_runs = 3
        @at_bats = 75
      end

      it "should return a 0 slugging percentage" do
        assert_equal 0, StatsCalculator.slugging_percentage(@hits, @doubles, @triples, @home_runs, @at_bats)
      end
    end

    describe "when hits is more than at_bats" do
      before do
        @hits = 90
        @doubles = 5
        @triples = 1
        @home_runs = 3
        @at_bats = 75
      end

      it "should return a 0 slugging percentage" do
        assert_equal 0, StatsCalculator.slugging_percentage(@hits, @doubles, @triples, @home_runs, @at_bats)
      end
    end

    describe "when at_bats is zero" do
      before do
        @hits = 20
        @doubles = 5
        @triples = 1
        @home_runs = 3
        @at_bats = 0
      end

      it "should return a 0 slugging percentage" do
        assert_equal 0, StatsCalculator.slugging_percentage(@hits, @doubles, @triples, @home_runs, @at_bats)
      end
    end
  end

end
