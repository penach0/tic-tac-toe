require_relative '../lib/game'
# require_relative '../lib/player'

describe Game do
  describe '#game_won?' do
    subject(:game_won) { described_class.new }
    let(:board) { game_won.board }

    before(:each) do
      game_won.current_player = current_player
    end

    context 'game ends when win condition is met' do
      context 'horizontal wins' do
        let(:current_player) { instance_double('Player', mark: 'X') }
        it 'ends when X completes top line' do
          allow(board).to receive(:get_positions).with('X').and_return([1, 2, 3])
          expect(game_won.game_won?).to be true
        end

        it 'ends when X completes middle line' do
          allow(board).to receive(:get_positions).with('X').and_return([4, 5, 6])
          expect(game_won.game_won?).to be true
        end

        it 'ends when X completes the bottom line' do
          allow(board).to receive(:get_positions).with('X').and_return([7, 8, 9])
          expect(game_won.game_won?).to be true
        end
      end

      context 'vertical wins' do
        let(:current_player) { instance_double('Player', mark: 'O') }
        it 'ends when O completes the left line' do
          allow(board).to receive(:get_positions).with('O').and_return([1, 4, 7])
          expect(game_won.game_won?).to be true
        end

        it 'ends when O completes the middle line' do
          allow(board).to receive(:get_positions).with('O').and_return([2, 5, 8])
          expect(game_won.game_won?).to be true
        end

        it 'ends when O completes the right line' do
          allow(board).to receive(:get_positions).with('O').and_return([3, 6, 9])
          expect(game_won.game_won?).to be true
        end
      end

      context 'diagonal wins' do
        let(:current_player) { instance_double('Player', mark: 'X') }
        it 'ends when X completes top left diagonal' do
          allow(board).to receive(:get_positions).with('X').and_return([1, 5, 9])
          expect(game_won.game_won?).to be true
        end

        it 'ends when O completes top right diagonal' do
          allow(board).to receive(:get_positions).with('X').and_return([3, 5, 7])
          expect(game_won.game_won?).to be true
        end
      end
    end

    context 'game does not end when winning condition is not met' do
      let(:current_player) { instance_double('Player', mark: 'X') }
      it 'does not end when X has no winning lines' do
        allow(board).to receive(:get_positions).with('X').and_return([1, 3, 4, 5])
        expect(game_won.game_won?).to be false
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
    let(:current_player) { instance_double('Player', mark: 'X') }

    context 'when entering a char that is not a number' do
      before do
        non_number1 = '_'
        non_number2 = 'a'
        valid_input = '5'
        allow(game_square).to receive(:gets).and_return(non_number1, non_number2, valid_input)
      end

      it 'warns the user the char is not permitted' do
        game_square.current_player = current_player
        initial_message = "#{current_player.mark} playing, pick a number:"
        error_message = 'Not valid. Please pick another: '

        expect(game_square).to receive(:print).with(initial_message)
        expect(game_square).to receive(:print).with(error_message).twice
        game_square.pick_square
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
        game_square.current_player = current_player
        initial_message = "#{current_player.mark} playing, pick a number:"
        error_message = 'Not valid. Please pick another: '

        expect(game_square).to receive(:print).with(initial_message)
        expect(game_square).to receive(:print).with(error_message).twice
        game_square.pick_square
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
        game_square.current_player = current_player
        initial_message = "#{current_player.mark} playing, pick a number:"
        error_message = 'Not valid. Please pick another: '
        expect(game_square).to receive(:print).with(initial_message)
        expect(game_square).to receive(:print).with(error_message)
        game_square.pick_square
      end
    end
    context 'when entering a play character (X)' do
      before do
        play_char = 'X'
        valid_input = '5'
        allow(game_square).to receive(:gets).and_return(play_char, valid_input)
      end

      it 'warns the users of invalid input' do
        game_square.current_player = current_player
        initial_message = "#{current_player.mark} playing, pick a number:"
        error_message = 'Not valid. Please pick another: '
        expect(game_square).to receive(:print).with(initial_message)
        expect(game_square).to receive(:print).with(error_message)
        game_square.pick_square
      end
    end

    context 'when entering a valid number' do
      before do
        valid_input = '5'
        allow(game_square).to receive(:gets).and_return(valid_input)
      end

      it 'ends the loop and returns the correct square object' do
        game_square.current_player = current_player
        square = instance_double('Square', value: 5)
        return_square = game_square.pick_square
        expect(return_square.value).to eq(square.value)
      end
    end
  end

  describe '#play' do
    subject(:game_play) { described_class.new }
    let(:current_player) { instance_double('Player', mark: 'X') }
    victory_message = 'X player won! Congratulations!'
    draw_message = 'It\'s a draw! Well played by both.'

    context 'when #game_won is false once' do
      before do
        allow(game_play).to receive(:game_setup)
        allow(game_play).to receive(:game_won?).and_return(false, true)
        allow(game_play).to receive(:play_again?).and_return(false)
        allow(game_play).to receive(:end_message).and_return(victory_message)
      end
      it 'calls #turn twice and #change_player once and displays victory message' do
        game_play.current_player = current_player
        victory_message = "#{current_player.mark} player won! Congratulations!"
        expect(game_play).to receive(:turn).twice
        expect(game_play).to receive(:change_player).once
        expect(game_play).to receive(:puts).with(victory_message)
        game_play.play
      end
    end
    context 'when is not finished once and then drawn' do
      before do
        allow(game_play).to receive(:game_setup)
        allow(game_play).to receive(:game_drawn?).and_return(false, true)
        allow(game_play).to receive(:play_again?).and_return(false)
        allow(game_play).to receive(:end_message).and_return(draw_message)
      end
      it 'calls #turn twice and #change_player once and displays draw message' do
        game_play.current_player = current_player
        expect(game_play).to receive(:turn).twice
        expect(game_play).to receive(:change_player).and_return(current_player)
        expect(game_play).to receive(:puts).with(draw_message)
        game_play.play
      end
    end

    context 'when play again is true once' do
      let(:new_game) { described_class.new }
      before do
        allow(game_play).to receive(:game_setup)
        allow(game_play).to receive(:game_won?).and_return(true)
        allow(game_play).to receive(:play_again?).and_return(true)
        allow(Game).to receive(:new).and_return(new_game)
      end
      it 'calls play on new Game instance' do
        game_play.current_player = current_player
        new_game.current_player = current_player
        expect(game_play).to receive(:turn)
        expect(Game).to receive(:new)
        expect(new_game).to receive(:play)
        game_play.play
      end
    end
  end

  describe '#play_again?' do
    subject(:game_again) { described_class.new }
    context 'if the answer is No' do
      before do
        answer = 'n'
        allow(game_again).to receive(:gets).and_return(answer)
      end
      it 'returns false' do
        expect(game_again.play_again?).to be false
      end
    end

    context 'if the answer is Yes' do
      before do
        answer = 'Y'
        allow(game_again).to receive(:gets).and_return(answer)
      end
      it 'returns true' do
        expect(game_again.play_again?).to be true
      end
    end

    context 'if the input is invalid once' do
      before do
        invalid_input = '3'
        answer = 'N'
        allow(game_again).to receive(:gets).and_return(invalid_input, answer)
      end
      it 'runs the loop twice' do
        initial_prompt = 'Play again? (y/n): '
        warning_message = 'Please enter a valid input (y/n): '
        expect(game_again).to receive(:print).with(initial_prompt)
        expect(game_again).to receive(:print).with(warning_message)
        game_again.play_again?
      end
    end
  end
end
