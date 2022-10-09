require_relative '../tic_tac_toe'

describe Game do
  subject(:game) { described_class.new }
  let(:board) { Board.new }

  describe '#check_if_won?' do
    context 'game ends when win condition is met' do
      before do
        allow(board).to receive(:get_positions).with('X').and_return([1, 2, 3])
      end
      it 'ends when X completes top line' do
        expect(game.check_if_won?(board, 'X')).to be true
      end
    end
  end
end
