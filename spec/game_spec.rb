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

        it 'ends when O completes the bottom line' do
          allow(board).to receive(:get_positions).with('O').and_return([7, 8, 9])
          expect(game.game_won?(board, 'O')).to be true
        end
      end

      context 'vertical wins' do
        it 'ends when O completes the left line' do
          allow(board).to receive(:get_positions).with('O').and_return([1, 4, 7])
          expect(game.game_won?(board, 'O')).to be true
        end

        it 'ends when X completes the middle line' do
          allow(board).to receive(:get_positions).with('X').and_return([2, 5, 8])
          expect(game.game_won?(board, 'X')).to be true
        end

        it 'ends when O completes the right line' do
          allow(board).to receive(:get_positions).with('O').and_return([3, 6, 9])
          expect(game.game_won?(board, 'O')).to be true
        end
      end

      context 'diagonal wins' do
        it 'ends when X completes top left diagonal' do
          allow(board).to receive(:get_positions).with('X').and_return([1, 5, 9])
          expect(game.game_won?(board, 'X')).to be true
        end

        it 'ends when O completes top right diagonal' do
          allow(board).to receive(:get_positions).with('O').and_return([3, 5, 7])
          expect(game.game_won?(board, 'O')).to be true
        end
      end
    end

    context 'game does not end when winning condition is not met' do
      it 'does not end when X has no winning lines' do
        allow(board).to receive(:get_positions).with('X').and_return([1, 3, 4, 5])
        expect(game.game_won?(board, 'X')).to be false
      end
    end
  end
end
