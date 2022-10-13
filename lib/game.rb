require_relative 'board'
require_relative 'square'

# This class handles the operations necessary to run a game of tic-tac-toe
class Game
  attr_reader :board, :player1, :player2
  attr_accessor :current_player

  WIN_CONDITIONS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                    [1, 4, 7], [2, 5, 8], [3, 6, 9],
                    [1, 5, 9], [3, 5, 7]].freeze

  def initialize
    @board = Board.new
  end

  def play
    game_setup
    loop do
      turn
      break if game_won? || game_drawn?

      @current_player = change_player
    end
    puts end_message
    Game.new.play if play_again?
  end

  def create_players(choice)
    @player1 = Player.new(choice)
    @player2 = Player.new(choice == 'crosses' ? 'circles' : 'crosses')
  end

  def play_again?
    print 'Play again? (y/n): '
    loop do
      answer = gets.chomp.downcase
      return true if answer == 'y'
      return false if answer == 'n'

      print 'Please enter a valid input (y/n): '
    end
  end

  def pick_mark
    print 'Pick your choice (Crosses or Circles): '
    loop do
      choice = gets.chomp.downcase
      return choice if %w[crosses circles].include?(choice)

      print 'That is not a valid option. Try again: '
    end
  end

  def pick_square
    print "#{@current_player.mark} playing, pick a number:"
    loop do
      number = gets.chomp.to_i
      square = board.get_square(number)
      return square unless square.nil?

      print 'Not valid. Please pick another: '
    end
  end

  def game_won?
    WIN_CONDITIONS.each do |line|
      return true if (line - board.get_positions(@current_player.mark)).empty?
    end
    false
  end

  private

  def game_setup
    create_players(pick_mark)
    @current_player = player1
    show_board
  end

  def turn
    pick_square.play(@current_player.mark)
    show_board
  end

  def change_player
    @current_player == player1 ? player2 : player1
  end

  def game_drawn?
    board.full? && (game_won? == false)
  end

  def show_board
    board_array = board.board
    board_array.each_with_index do |_row, index|
      puts " #{board_array[index][0].value} | #{board_array[index][1].value} | #{board_array[index][2].value} "
    end
  end

  def end_message
    return "#{@current_player.mark} player won! Congratulations!" if game_won?
    return 'It\'s a draw! Well played by both.' if game_drawn?
  end
end
