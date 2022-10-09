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

class Board
  attr_reader :board

  def initialize
    @board = Array.new(3) { Array.new(3) }
                  .map do |row|
                    row.map { Square.new }
                  end
  end

  def show_board
    @board.each_with_index do |_row, index|
      puts " #{@board[index][0].value} | #{@board[index][1].value} | #{@board[index][2].value} "
    end
  end

  def get_number(number)
    @board.flatten.each.with_index(1) do |square, index|
      return square if index == number
    end
  end

  def get_positions(play)
    positions = []
    @board.flatten.each do |square|
      positions << square.position if square.value == play
    end
    positions
  end
end

class Square
  attr_accessor :value
  attr_reader :position

  @@square_counter = 1

  def initialize
    @position = @@square_counter
    @value = @position
    @is_played = false
    @@square_counter += 1
  end

  def played(play)
    return if @is_played

    self.value = play
    @is_played = true
  end
end

class Player
  attr_reader :player_number, :play

  def initialize(player_number, choice)
    @player_number = player_number
    case choice
    when 'crosses'
      @play = 'X'
    when 'circles'
      @play = 'O'
    end
  end
end

# main
=begin 
player1 = ''
game = Game.new
board = Board.new
options = Array(1..9)

def check_player_choice(choice)
  choice.casecmp('crosses').zero? || choice.casecmp('circles').zero?
end

puts 'Pick your choice (Crosses or Circles):'

until check_player_choice(player1)
  player1 = gets.chomp.downcase
  puts 'Not a valid option' unless check_player_choice(player1)
end

player2 = (player1 == 'crosses' ? 'circles' : 'crosses')

player1 = Player.new(1, player1)
player2 = Player.new(2, player2)

board.show_board

i = 1
while i <= 9

  number = 0

  current_player = i.odd? ? player1 : player2

  puts "#{current_player.play} playing, pick a number:"
  until options.include?(number)
    number = gets.chomp.to_i
    puts 'Not valid, number is not playable. Please pick another:' unless options.include?(number)
  end

  board.get_number(number).played(current_player.play)
  options.delete(number)
  board.show_board

  if game.check_if_won?(board, current_player.play)
    puts "Game over. Player #{current_player.player_number} (#{current_player.play}) won!!"
    break
  end

  puts 'Its a draw!' if options.empty?

  i += 1
end
=end