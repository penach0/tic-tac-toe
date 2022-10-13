# Represents a tic-tac-toe board and holds methods
# to query information from its status
class Board
  attr_reader :board

  def initialize
    @board = create_board
  end

  def create_board
    count = 0
    Array.new(3) { Array.new(3) }.map do |row|
      row.map do
        count += 1
        Square.new(count)
      end
    end
  end

  def get_square(number)
    board.flatten.find { |square| square.value == number }
  end

  def get_positions(mark)
    positions = []
    @board.flatten.each do |square|
      positions << square.position if square.value == mark
    end
    positions
  end

  def full?
    board.flatten.none? { |square| square.value.is_a?(Integer) }
  end
end
