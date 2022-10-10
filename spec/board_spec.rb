require_relative '../lib/board'
require_relative '../lib/square'

describe Board do
  subject(:board) { described_class.new }

  describe '#get_square' do
    let(:valid_square) { instance_double('Square', value: 5) }
    let(:played_square) { instance_double('Square', value: 'X') }

    context 'when number is valid' do
      it 'returns the corresponding square' do
        query_square = board.get_square(5)
        expect(query_square.value).to eq(valid_square.value)
      end
    end
    context 'when number is invalid' do
      it 'returns nil if the number is not in range (1..9)' do
        expect(board.get_square(11)).to be nil
      end

      it 'returns nil if the square is already played' do
        board.board[1][1] = played_square
        expect(board.get_square(5)).to be nil
      end
    end
  end

  describe '#get_positions' do
    context 'when no plays have been made' do
      it 'returns an empty array' do
        expect(board.get_positions('X')).to eq([])
      end
    end
    context 'when plays have been made' do
      before do
        @full_board = board.board.map do |square|
          case square.position
          when 1, 3, 5, 8 then square.value = 'X'
          when 2, 4, 6, 7, 9 then square.value = 'O'
          end
        end
      end
      it 'returns array when play is X' do
        expect(@full_board.get_positions('X')).to eq([1, 3, 5, 8])
      end
      it 'returns array when play is O'
    end
  end
end
