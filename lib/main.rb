require_relative 'game'
require_relative 'board'
require_relative 'player'
require_relative 'square'

game = Game.new
board = Board.new
options = Array(1..9)

def pick_play
  print 'Pick your choice (Crosses or Circles): '
  loop do
    play = gets.chomp.downcase
    return play if %w[crosses circles].include?(play)

    print 'That is not a valid option. Try again:'
  end
end

player1 = pick_play
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

  board.get_square(number).played(current_player.play)
  options.delete(number)
  board.show_board
  p board.get_positions('X')
  p board.get_positions('O')

  if game.game_won?(board, current_player.play)
    puts "Game over. Player #{current_player.player_number} (#{current_player.play}) won!!"
    break
  end

  i += 1
end
