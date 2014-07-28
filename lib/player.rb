class Player
  require 'csv'

  attr_accessor :player_id, :birth_year, :first_name, :last_name

  def initialize(csv_row)
    return unless csv_row
    self.player_id = csv_row["playerID"]
    self.birth_year = csv_row["birthYear"]
    self.first_name = csv_row["nameFirst"]
    self.last_name = csv_row["nameLast"]

  end

end
