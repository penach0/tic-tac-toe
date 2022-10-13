require_relative '../lib/game'
# require_relative '../lib/player'

describe Game do
  describe '#game_won?' do
    subject(:game_won) { described_class.new }
    let(:board) { game_won.board }

    context 'game ends when win condition is met' do
      context 'horizontal wins' do
        it 'ends when X completes top line' do
          allow(board).to receive(:get_positions).with('X').and_return([1, 2, 3])
          expect(game_won.game_won?('X')).to be true
        end

        it 'ends when X completes middle line' do
          allow(board).to receive(:get_positions).with('X').and_return([4, 5, 6])
          expect(game_won.game_won?('X')).to be true
        end

        it 'ends when O completes the bottom line' do
          allow(board).to receive(:get_positions).with('O').and_return([7, 8, 9])
          expect(game_won.game_won?('O')).to be true
        end
      end

      context 'vertical wins' do
        it 'ends when O completes the left line' do
          allow(board).to receive(:get_positions).with('O').and_return([1, 4, 7])
          expect(game_won.game_won?('O')).to be true
        end

        it 'ends when X completes the middle line' do
          allow(board).to receive(:get_positions).with('X').and_return([2, 5, 8])
          expect(game_won.game_won?('X')).to be true
        end

        it 'ends when O completes the right line' do
          allow(board).to receive(:get_positions).with('O').and_return([3, 6, 9])
          expect(game_won.game_won?('O')).to be true
        end
      end

      context 'diagonal wins' do
        it 'ends when X completes top left diagonal' do
          allow(board).to receive(:get_positions).with('X').and_return([1, 5, 9])
          expect(game_won.game_won?('X')).to be true
        end

        it 'ends when O completes top right diagonal' do
          allow(board).to receive(:get_positions).with('O').and_return([3, 5, 7])
          expect(game_won.game_won?('O')).to be true
        end
      end
    end

    context 'game does not end when winning condition is not met' do
      it 'does not end when X has no winning lines' do
        allow(board).to receive(:get_positions).with('X').and_return([1, 3, 4, 5])
        expect(game_won.game_won?('X')).to be false
      end
    end
  end

  describe '#pick_mark' do
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
        game_pick.pick_mark
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
        game_pick.pick_mark
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

  describe '#pick_square' do
    subject(:game_square) { described_class.new }
    let(:current_player) { double('Player', mark: 'X') }

    context 'when entering a char that is not a number' do
      before do
        non_number1 = '_'
        non_number2 = 'a'
        valid_input = '5'
        allow(game_square).to receive(:gets).and_return(non_number1, non_number2, valid_input)
      end

      it 'warns the user the char is not permitted' do
        initial_message = "#{current_player.mark} playing, pick a number:"
        error_message = 'Not valid. Please pick another: '

        expect(game_square).to receive(:print).with(initial_message)
        expect(game_square).to receive(:print).with(error_message).twice
        game_square.pick_square(current_player)
      end
    end
    context 'when entering a number outside of range' do
      before do
        outside_number1 = '11'
        outside_number2 = '0'
        valid_input = '6'
        allow(game_square).to receive(:gets).and_return(outside_number1, outside_number2, valid_input)
      end
      it 'warns the user the number is outside range' do
        initial_message = "#{current_player.mark} playing, pick a number:"
        error_message = 'Not valid. Please pick another: '

        expect(game_square).to receive(:print).with(initial_message)
        expect(game_square).to receive(:print).with(error_message).twice
        game_square.pick_square(current_player)
      end
    end
    context 'when entering a number already played' do
      before do
        already_played = '5'
        valid_input = '9'
        allow(game_square).to receive(:gets).and_return(already_played, valid_input)
        allow(game_square.board).to receive(:get_square).with(already_played.to_i).and_return nil
        allow(game_square.board).to receive(:get_square).with(valid_input.to_i).and_call_original
      end
      it 'warns the user that the number has been played' do
        initial_message = "#{current_player.mark} playing, pick a number:"
        error_message = 'Not valid. Please pick another: '
        expect(game_square).to receive(:print).with(initial_message)
        expect(game_square).to receive(:print).with(error_message)
        game_square.pick_square(current_player)
      end
    end
    context 'when entering a play character (X)' do
      before do
        play_char = 'X'
        valid_input = '5'
        allow(game_square).to receive(:gets).and_return(play_char, valid_input)
      end

      it 'warns the users of invalid input' do
        initial_message = "#{current_player.mark} playing, pick a number:"
        error_message = 'Not valid. Please pick another: '
        expect(game_square).to receive(:print).with(initial_message)
        expect(game_square).to receive(:print).with(error_message)
        game_square.pick_square(current_player)
      end
    end

    context 'when entering a valid number' do
      before do
        valid_input = '5'
        allow(game_square).to receive(:gets).and_return(valid_input)
      end

      it 'ends the loop and returns the correct square object' do
        square = instance_double('Square', value: 5)
        return_square = game_square.pick_square(current_player)
        expect(return_square.value).to eq(square.value)
      end
    end
  end

  describe '#play' do
    subject(:game_play) { described_class.new }
    let(:current_player) { instance_double('Player', mark: 'X') }
    context 'when #game_won is false once' do
      before do
        allow(game_play).to receive(:game_setup)
        allow(game_play).to receive(:game_won?).and_return(false, true)
      end
      it 'calls #turn and #change_player once' do
        game_play.current_player = current_player
        expect(game_play).to receive(:turn).once
        expect(game_play).to receive(:change_player).once
        game_play.play
      end
    end
  end
end
