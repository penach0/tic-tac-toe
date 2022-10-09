player1 = ''
game = Game.new
board = Board.new
options = Array(1..9)

puts 'Pick your choice (Crosses or Circles):'

until player1.casecmp('crosses').zero? || player1.casecmp('circles').zero?
  player1 = gets.chomp.downcase
  puts 'Not a valid option' unless player1.casecmp('crosses').zero? || player1.casecmp('circles').zero?
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

  i += 1
end
