require_relative '../lib/board'
require_relative '../lib/square'

describe Board do
  subject(:board) { described_class.new }

  def fill_board
    board.board.each do |row|
      row.each do |square|
        case square.position
        when 1, 3, 5, 8 then square.value = 'X'
        when 2, 4, 6, 7, 9 then square.value = 'O'
        end
      end
    end
  end

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
        fill_board
      end
      it 'returns array when play is X' do
        expect(board.get_positions('X')).to eq([1, 3, 5, 8])
      end
      it 'returns array when play is O' do
        expect(board.get_positions('O')).to eq([2, 4, 6, 7, 9])
      end
    end
  end

  describe '#full?' do
    context 'when board is empty' do
      it 'returns false' do
        expect(board).not_to be_full
      end
    end

    context 'when board is not full' do
      it 'returns false' do
        board.board[0][0].value = 'X'
        board.board[2][1].value = 'O'
        expect(board).not_to be_full
      end
    end

    context 'when the board is full' do
      it 'returns true' do
        fill_board
        expect(board).to be_full
      end
    end
  end
end
