class Player
  attr_reader :play

  def initialize(choice)
    @play = (choice == 'crosses' ? 'X' : 'O')
  end
end
