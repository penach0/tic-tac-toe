class Game
  def initialize
    @win_conditions = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                       [1, 4, 7], [2, 5, 8], [3, 6, 9],
                       [1, 5, 9], [3, 5, 7]]
  end

  def check_if_won?(board, play)
    won = false
    @win_conditions.each do |line|
      won = (line - board.get_positions(play)).empty?
      break if won == true
    end
    won
  end
end
