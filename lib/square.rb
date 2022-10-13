# Represents a single square of a tic-tac-toe board
# Holds methods relevant to inspecting and changing its status
class Square
  attr_accessor :value
  attr_reader :position

  def initialize(value)
    @position = value
    @value = value
  end

  def played?
    %w[X O].include?(value)
  end

  def play(mark)
    return if played?

    self.value = mark
  end
end
