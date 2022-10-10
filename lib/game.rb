class Game
  def initialize
    @win_conditions = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                       [1, 4, 7], [2, 5, 8], [3, 6, 9],
                       [1, 5, 9], [3, 5, 7]]
  end

  def pick_play
    print 'Pick your choice (Crosses or Circles): '
    loop do
      play = gets.chomp.downcase
      return play if %w[crosses circles].include?(play)

      print 'That is not a valid option. Try again:'
    end
  end

  def game_won?(board, play)
    @win_conditions.each do |line|
      return true if (line - board.get_positions(play)).empty?
    end
    false
  end
end
