class Slugger

  attr_accessor :players, :batting_stats

  def initialize(player_data_file = nil, stats_data_file = nil)
    player_file = player_data_file || File.expand_path('../../data/Master-small.csv', __FILE__)
    stats_file = stats_data_file || File.expand_path('../../data/Batting-07-12.csv', __FILE__)
    self.players = Player.load_from_data_file(player_file)
    self.batting_stats = BattingStatistic.load_from_data_file(stats_file)
  end

  def run
    most_improved_batter = batter_with_most_improved_batting_average(2009, 2010)
    puts "The most improved batting average from 2007 to 2008: #{most_improved_batter}."
    oakland_2007_stats = team_player_slugging_percentages_for_year("OAK", 2007)
    puts "Slugging percentages for Oakland players in 2007:"
    oakland_2007_stats.each do |o|
      puts "#{o[0].to_s} - #{o[1].round(3)}"
    end

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

  def team_player_slugging_percentages_for_year(team_id, year)
    result = []
    players_stats = BattingStatistic.stats_for_all_players_on_team_in_year(batting_stats, team_id, year)
    players_stats.each do |player_id, stats|
      result << [players[player_id], stats[:slugging_percentage]]
    end
    result
  end

  def top_player_in_category_for_year(year, category, min_at_bats)
    top_person_id = nil
    top_category_value = -9.999
    player_stats = BattingStatistic.stats_for_all_players_in_year(batting_stats, year)
    player_stats.each do |person_id, stats|
      if stats[:at_bats] >= min_at_bats && stats[category.to_sym] && stats[category.to_sym] > top_category_value
        top_person_id = person_id
        top_category_value = stats[category.to_sym]
      end
    end
    top_person_id
  end

end
