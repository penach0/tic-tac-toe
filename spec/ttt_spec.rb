require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }
  let(:board) { double('board') }

  describe '#game_won?' do
    context 'game ends when win condition is met' do
      context 'horizontal wins' do
        it 'ends when X completes top line' do
          allow(board).to receive(:get_positions).with('X').and_return([1, 2, 3])
          expect(game.game_won?(board, 'X')).to be true
        end

        it 'ends when X completes middle line' do
          allow(board).to receive(:get_positions).with('X').and_return([4, 5, 6])
          expect(game.game_won?(board, 'X')).to be true
        end
      end
    end
  end
end
