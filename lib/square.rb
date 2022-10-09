class Square
  attr_accessor :value
  attr_reader :position

  def initialize(value)
    @position = value
    @value = value
    @is_played = false
  end

  def played(play)
    return if @is_played

    self.value = play
    @is_played = true
  end
end
