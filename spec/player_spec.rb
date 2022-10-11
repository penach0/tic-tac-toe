require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    context 'when passed crosses as a choice' do
      choice = 'crosses'
      subject(:player_x) { described_class.new(choice) }
      it 'sets @play to X' do
        expect(player_x.play).to eq('X')
      end
    end
    context 'when passed circles as a choice' do
      choice = 'circles'
      subject(:player_o) { described_class.new(choice)}
      it 'sets @play to O' do
        expect(player_o.play).to eq('O')
      end
    end
  end
end
