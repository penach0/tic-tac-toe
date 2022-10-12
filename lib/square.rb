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

  def play(play)
    return if played?

    self.value = play
  end
end
