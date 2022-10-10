require_relative '../lib/board'
require_relative '../lib/square'

describe Board do
  subject(:board) { described_class.new }

  describe '#get_square' do
    let(:square) { instance_double('Square', value: 5) }

    context 'when number is valid' do
      it 'returns the corresponding square' do
        query_square = board.get_square(5)
        expect(query_square.value).to eq(square.value)
      end
      it 'returns nil if the number is not in range (1..9)' do
        expect(board.get_square(11)).to be nil
      end
    end
  end
end
