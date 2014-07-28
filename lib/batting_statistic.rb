class BattingStatistic
  require 'csv'

  attr_accessor :player_id, :year, :league, :team_id, :games,
                :at_bats, :runs, :hits, :doubles, :triples, :home_runs, :rbi

  def initialize(csv_row)
    return unless csv_row
    self.player_id = csv_row["playerID"]
    self.year = csv_row["yearID"]
    self.league = csv_row["league"]
    self.team_id = csv_row["teamID"]
    self.games = csv_row["G"]
    self.at_bats = csv_row["AB"]
    self.runs = csv_row["R"]
    self.hits = csv_row["H"]
    self.doubles = csv_row["2B"]
    self.triples = csv_row["3B"]
    self.home_runs = csv_row["HR"]
    self.rbi = csv_row["RBI"]
  end

end
