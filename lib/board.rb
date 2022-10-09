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
