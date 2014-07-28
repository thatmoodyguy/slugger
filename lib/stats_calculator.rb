class StatsCalculator

  def self.batting_average(hits, at_bats)
    return 0 unless hits >= 0 && at_bats > 0
    hits.to_f / at_bats
  end

  def self.slugging_percentage(hits, doubles, triples, home_runs, at_bats)
    return 0 unless hits <= at_bats
    return 0 unless at_bats > 0
    singles = hits - (doubles + triples + home_runs)
    return 0 unless singles >= 0
    (singles + (2 * doubles) + (3 * triples) + (4 * home_runs)).to_f / at_bats
  end
end
