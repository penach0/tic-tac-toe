class Square
  attr_accessor :value
  attr_reader :position

  @@square_counter = 1

  def initialize
    @position = @@square_counter
    @value = @position
    @is_played = false
    @@square_counter += 1
  end

  def played(play)
    return if @is_played

    self.value = play
    @is_played = true
  end
end
