class Slugger

  attr_accessor :players, :batting_stats

  def initialize(player_data_file = nil, stats_data_file = nil)
    puts "Slugger is loading and analyzing your data..."
    player_file = player_data_file || File.expand_path('../../data/Master-small.csv', __FILE__)
    stats_file = stats_data_file || File.expand_path('../../data/Batting-07-12.csv', __FILE__)
    self.players = Player.load_from_data_file(player_file)
    self.batting_stats = BattingStatistic.load_from_data_file(stats_file)
  end

  def run
    most_improved_batter = batter_with_most_improved_batting_average(2009, 2010)
    puts "The most improved batting average from 2007 to 2008: #{most_improved_batter}."
  end

  def batter_with_most_improved_batting_average(original_year, new_year)
    top_player = nil
    top_improvement = -999.0
    players.each do |player_id, player|
      stats_old = BattingStatistic.stats_for_player_and_year(batting_stats, player_id, original_year)
      stats_new = BattingStatistic.stats_for_player_and_year(batting_stats, player_id, new_year)
      if stats_old[:at_bats] >= 200 && stats_new[:at_bats] >= 200
        improvement = stats_new[:batting_average] - stats_old[:batting_average]
        if improvement > top_improvement
          top_improvement = improvement
          top_player = player
        end
      end
    end
    top_player
  end

end
