class Player
  attr_reader :player_number, :play

  def initialize(player_number, choice)
    @player_number = player_number
    case choice
    when 'crosses'
      @play = 'X'
    when 'circles'
      @play = 'O'
    end
  end
end
