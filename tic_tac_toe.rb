class Board
  @@square_counter = 1
  attr_reader :board

  def initialize
    @board = Array.new(3) { Array.new(3) }
                  .map do |row|
                    row.map do |square|
                    square = Square.new
                    end
                  end
  end

  def show_board
    @board.each_with_index do |_row, index|
      puts " #{@board[index][0].value} | #{@board[index][1].value} | #{@board[index][2].value} "
    end
  end
end

class Square < Board
  attr_accessor :value
  attr_writer :played

  def initialize
    @value = @@square_counter
    @played = false
    @@square_counter += 1
  end

  def played(play) 
    if @played == false
      self.value = play
      @played == true
    end
  end
end

# Want to create to player instances able to update squares
class Player
  def initialize(choice)
    case choice
    when 'Crosses'
      @play = 'X'
    when 'Circles'
      @play = 'O'
    end
  end

  def play(number)
    # Method to accept number and pass it to played(play) on the right square
  end
end

# Some statements to test output
board = Board.new
pp board
board.show_board
board.board[0][0].played('O')
board.show_board

pp board