require_relative 'board'
require_relative 'square'

class Game
  attr_reader :board, :player1, :player2
  attr_accessor :current_player

  def initialize
    @win_conditions = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                       [1, 4, 7], [2, 5, 8], [3, 6, 9],
                       [1, 5, 9], [3, 5, 7]]
    @board = Board.new
  end

  def game_setup
    create_players(pick_mark)
    @current_player = player1
  end

  def play
    game_setup
    until game_won?(current_player.mark) || game_drawn?
      turn(current_player)
      current_player = change_player(current_player)
    end
  end

  def turn(current_player)
    show_board
    pick_square(current_player).play
  end

  def change_player(player)
    player == player1 ? player2 : player1
  end

  def pick_mark
    print 'Pick your choice (Crosses or Circles): '
    loop do
      choice = gets.chomp.downcase
      return choice if %w[crosses circles].include?(choice)

      print 'That is not a valid option. Try again: '
    end
  end

  def create_players(choice)
    @player1 = Player.new(choice)
    @player2 = Player.new(choice == 'crosses' ? 'circles' : 'crosses')
  end

  def pick_square(current_player)
    print "#{current_player.mark} playing, pick a number:"
    loop do
      number = gets.chomp.to_i
      square = board.get_square(number)
      return square unless square.nil?

      print 'Not valid. Please pick another: '
    end
  end

  def game_won?(mark)
    @win_conditions.each do |line|
      return true if (line - board.get_positions(mark)).empty?
    end
    false
  end

  def game_drawn?
    board.full? && (game_won? == false)
  end

  def show_board
    board.each_with_index do |_row, index|
      puts " #{board[index][0].value} | #{board[index][1].value} | #{board[index][2].value} "
    end
  end
end
