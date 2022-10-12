require_relative '../lib/square'

describe Square do
  subject(:played_square) { described_class.new('5') }
  subject(:unplayed_square) { described_class.new('6') }

  describe '#played?' do
    context 'when square is played' do
      it 'returns true' do
        played_square.value = 'X'
        expect(played_square).to be_played
      end
    end

    context 'when square is not played' do
      it 'returns false if the square value is a number' do
        expect(unplayed_square).not_to be_played
      end
    end
  end

  describe '#play' do
    context 'if square is played' do
      it 'returns nil' do
        played_square.value = 'X'
        mark = 'O'
        expect(played_square.play(mark)).to be nil
      end
    end

    context 'if square is not played' do
      it 'changes value to correct mark' do
        mark = 'O'
        unplayed_square.play(mark)
        expect(unplayed_square.value).to eq(mark)
      end
    end
  end
end
