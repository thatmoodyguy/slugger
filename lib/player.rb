class Player
  require 'csv'

  attr_accessor :player_id, :birth_year, :first_name, :last_name

  def initialize(csv_row)
    return unless csv_row
    self.player_id = csv_row["playerID"]
    self.birth_year = csv_row["birthYear"].to_i
    self.first_name = csv_row["nameFirst"]
    self.last_name = csv_row["nameLast"]
  end

  def self.load_from_data_file(file)
    players = {}
    CSV.foreach(file, headers: true) do |row|
      player = Player.new(row)
      players[player.player_id] = player unless player.player_id.nil?
    end
    players
  end

  def to_s
    "#{first_name} #{last_name}"
  end

  def self.player_ids_on_team_for_year(stats, team_id, year)
    stats.select {|p| p.team_id == team_id && p.year == year }.map(:player_id).uniq
  end

end
