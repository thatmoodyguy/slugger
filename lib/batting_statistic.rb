class BattingStatistic
  require 'csv'

  attr_accessor :player_id, :year, :league, :team_id, :games,
                :at_bats, :runs, :hits, :doubles, :triples, :home_runs, :rbi

  def initialize(csv_row)
    return unless csv_row
    self.player_id = csv_row["playerID"]
    self.year = csv_row["yearID"].to_i
    self.league = csv_row["league"]
    self.team_id = csv_row["teamID"]
    self.games = csv_row["G"].to_i
    self.at_bats = csv_row["AB"].to_i
    self.runs = csv_row["R"].to_i
    self.hits = csv_row["H"].to_i
    self.doubles = csv_row["2B"].to_i
    self.triples = csv_row["3B"].to_i
    self.home_runs = csv_row["HR"].to_i
    self.rbi = csv_row["RBI"].to_i
  end

  def self.load_from_data_file(file)
    stats = []
    CSV.foreach(file, headers: true) do |row|
      stat = BattingStatistic.new(row)
      stats << stat
    end
    stats
  end

end
