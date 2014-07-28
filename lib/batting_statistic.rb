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

  def self.stats_for_player_and_year(stats, player_id, year)
    aggregate(stats.select {|s| s.player_id == player_id && s.year.to_i == year })
  end

  def self.stats_for_all_players_on_team_in_year(stats, team_id, year)
    players_stats = {}
    player_ids = player_ids_on_team_for_year(stats, team_id, year)
    player_ids.each do |player_id|
      players_stats[player_id] = stats_for_player_and_year(stats, player_id, year)
    end
    players_stats
  end

  def self.player_ids_on_team_for_year(stats, team_id, year)
    stats.select {|p| p.team_id == team_id && p.year == year }.map(&:player_id).uniq
  end

  def self.all_player_ids_for_year(stats, year)
    stats.select {|p| p.year == year }.map(&:player_id).uniq
  end

  private

  def self.aggregate(array)
    stats = {
      :teams => array.map(&:team_id).uniq,
      :leagues => array.map(&:league).uniq,
      :games => array.map(&:games).inject(0, &:+),
      :at_bats => array.map(&:at_bats).inject(0, &:+),
      :runs => array.map(&:runs).inject(0, &:+),
      :hits => array.map(&:hits).inject(0, &:+),
      :doubles => array.map(&:doubles).inject(0, &:+),
      :triples => array.map(&:triples).inject(0, &:+),
      :home_runs => array.map(&:home_runs).inject(0, &:+),
      :rbi => array.map(&:rbi).inject(0, &:+),
    }
    stats[:batting_average] = StatsCalculator.batting_average(
                                              stats[:hits],
                                              stats[:at_bats])
    stats[:slugging_percentage] = StatsCalculator.slugging_percentage(
                                                    stats[:hits],
                                                    stats[:doubles],
                                                    stats[:triples],
                                                    stats[:home_runs],
                                                    stats[:at_bats]
                                                  )
    stats
  end

end
