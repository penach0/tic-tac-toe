# Main driver script to run the game
# Run `ruby lib/main.rb` on a terminal to play it

require_relative 'game'
require_relative 'board'
require_relative 'player'
require_relative 'square'

Game.new.play
