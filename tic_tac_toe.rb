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
end

class Square
  attr_accessor :value
  attr_writer :played

  @@square_counter = 1

  def initialize
    @value = @@square_counter
    @is_played = false
    @@square_counter += 1
  end

  def played(play)
    if @is_played == false
      self.value = play
      @is_played = true
    else
      puts 'Already played. Pick another one:'
    end
  end
end

class Player
  attr_accessor :play

  def initialize(choice)
    case choice
    when 'crosses'
      @play = 'X'
    when 'circles'
      @play = 'O'
    end
  end
end

# main

player1 = ''
player2 = ''
board = Board.new
options = Array(1..9)
puts options.inspect

puts 'Pick your choice (Crosses or Circles):'

until player1.casecmp('crosses').zero? || player1.casecmp('circles').zero?
  player1 = gets.chomp.downcase
end

if player1 == 'crosses'
  player2 = 'circles'
else
  player2 = 'crosses'
end

player1 = Player.new(player1)
player2 = Player.new(player2)

puts player1.inspect
puts player2.inspect

board.show_board

i = 1
while i <= 9

  number = 0

  if i.odd?
    turn = 'X'
    current_player = player1
  else
    turn = 'O'
    current_player = player2
  end

  puts "#{turn} playing, pick a number:"
  until options.include?(number)
    number = gets.chomp.to_i
    puts 'Not valid, number is not playable. Please pick another:'
  end

  board.get_number(number).played(current_player.play)

  options.delete(number)

  board.show_board

  i += 1
end
