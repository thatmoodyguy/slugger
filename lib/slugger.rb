class Slugger

  attr_accessor :players, :batting_stats

  def initialize
    player_file = File.expand_path '../../data/Master-small.csv', __FILE__
    stats_file = File.expand_path '../../data/Batting-07-12.csv', __FILE__
    self.players = Player.load_from_data_file(player_file)
    self.batting_stats = BattingStatistic.load_from_data_file(stats_file)
  end

  def run
    calculate_most_improved_batting_average(2009, 2010)
  end

  def calculate_most_improved_batting_average(original_year, new_year)

  end

end
