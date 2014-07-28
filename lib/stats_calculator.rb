class StatsCalculator

  def self.batting_average(hits, at_bats)
    return 0 unless hits >= 0 && at_bats > 0
    hits.to_f / at_bats
  end
end
