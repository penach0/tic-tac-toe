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

  def show_board
    @board.each_with_index do |_row, index|
      puts " #{@board[index][0].value} | #{@board[index][1].value} | #{@board[index][2].value} "
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
end
