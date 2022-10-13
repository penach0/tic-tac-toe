# Represents a player
class Player
  attr_reader :mark

  def initialize(choice)
    @mark = (choice == 'crosses' ? 'X' : 'O')
  end
end
