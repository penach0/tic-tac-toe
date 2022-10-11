require_relative '../lib/game'
require_relative '../lib/player'

describe Game do
  describe '#game_won?' do
    subject(:game_won) { described_class.new }
    let(:board) { double('board') }

    context 'game ends when win condition is met' do
      context 'horizontal wins' do
        it 'ends when X completes top line' do
          allow(board).to receive(:get_positions).with('X').and_return([1, 2, 3])
          expect(game_won.game_won?(board, 'X')).to be true
        end

        it 'ends when X completes middle line' do
          allow(board).to receive(:get_positions).with('X').and_return([4, 5, 6])
          expect(game_won.game_won?(board, 'X')).to be true
        end

        it 'ends when O completes the bottom line' do
          allow(board).to receive(:get_positions).with('O').and_return([7, 8, 9])
          expect(game_won.game_won?(board, 'O')).to be true
        end
      end

      context 'vertical wins' do
        it 'ends when O completes the left line' do
          allow(board).to receive(:get_positions).with('O').and_return([1, 4, 7])
          expect(game_won.game_won?(board, 'O')).to be true
        end

        it 'ends when X completes the middle line' do
          allow(board).to receive(:get_positions).with('X').and_return([2, 5, 8])
          expect(game_won.game_won?(board, 'X')).to be true
        end

        it 'ends when O completes the right line' do
          allow(board).to receive(:get_positions).with('O').and_return([3, 6, 9])
          expect(game_won.game_won?(board, 'O')).to be true
        end
      end

      context 'diagonal wins' do
        it 'ends when X completes top left diagonal' do
          allow(board).to receive(:get_positions).with('X').and_return([1, 5, 9])
          expect(game_won.game_won?(board, 'X')).to be true
        end

        it 'ends when O completes top right diagonal' do
          allow(board).to receive(:get_positions).with('O').and_return([3, 5, 7])
          expect(game_won.game_won?(board, 'O')).to be true
        end
      end
    end

    context 'game does not end when winning condition is not met' do
      it 'does not end when X has no winning lines' do
        allow(board).to receive(:get_positions).with('X').and_return([1, 3, 4, 5])
        expect(game_won.game_won?(board, 'X')).to be false
      end
    end
  end

  describe '#pick_play' do
    subject(:game_pick) { described_class.new }

    context 'when entering valid input' do
      before do
        valid_input = 'cRoSses'
        allow(game_pick).to receive(:gets).and_return(valid_input)
      end
      it 'stops looping and does not display error message' do
        initial_message = 'Pick your choice (Crosses or Circles): '
        error_message = 'That is not a valid option. Try again:'
        expect(game_pick).to receive(:print).with(initial_message)
        expect(game_pick).not_to receive(:print).with(error_message)
        game_pick.pick_play
      end
    end
    context 'when entering valid input' do
      before do
        invalid_input1 = 'Cicles'
        invalid_input2 = 'Rosses'
        valid_input = 'ciRcles'

        allow(game_pick).to receive(:gets).and_return(invalid_input1, invalid_input2, valid_input)
      end
      it 'displays error message and keeps looping' do
        initial_message = 'Pick your choice (Crosses or Circles): '
        error_message = 'That is not a valid option. Try again: '

        expect(game_pick).to receive(:print).with(initial_message)
        expect(game_pick).to receive(:print).with(error_message).twice
        game_pick.pick_play
      end
    end
  end

  describe '#create_players' do
    subject(:game_players) { described_class.new }
    let(:player) { class_double('Player').as_stubbed_const }
    context 'when choice is crosses' do
      choice = 'crosses'
      other_choice = 'circles'
      it 'instantiates players with the correct choices' do
        expect(player).to receive(:new).with(choice)
        expect(player).to receive(:new).with(other_choice)
        game_players.create_players(choice)
      end
    end
  end
end
