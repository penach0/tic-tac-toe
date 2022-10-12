require_relative '../lib/player'

describe Player do
  describe '#initialize' do
    context 'when passed crosses as a choice' do
      choice = 'crosses'
      subject(:player_x) { described_class.new(choice) }
      it 'sets @mark to X' do
        expect(player_x.mark).to eq('X')
      end
    end
    context 'when passed circles as a choice' do
      choice = 'circles'
      subject(:player_o) { described_class.new(choice)}
      it 'sets @mark to O' do
        expect(player_o.mark).to eq('O')
      end
    end
  end
end
