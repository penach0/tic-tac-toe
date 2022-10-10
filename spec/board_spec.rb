require_relative '../lib/board'
require_relative '../lib/square'

describe Board do
  subject(:board) { described_class.new }

  describe '#get_square' do
    context 'gets the square picked by the player' do
      it 'returns a square object when it is available' do
        square = instance_double('Square', value: 5)
        query_square = board.get_square(5)
        expect(query_square.value).to eq(square.value)
      end
      it 'returns nil if the number is not in range (1..9)'
    end
  end
end
