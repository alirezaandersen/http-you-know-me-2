require 'test_helper'

class GameTest < Minitest::Test

  def setup
    @conn = Faraday.new(url: 'http://127.0.0.1:9292') { |faraday|
      faraday.adapter  Faraday.default_adapter }
  end

  def test_content_length_returns_guessed_value
    #binding.pry
    response = @conn.post '/start_game'
    response = @conn.post '/game', 'guess=11'
    assert response.body.include?("Your 11 is too")
  end

  def test_computer_number_generates_random_number
    game = GameController.new
    num = 5.times.map do game.computer_number
      refute_equal -1, game.computer_number
    end
  end

  def test_computer_returns_player_guess_to_high
    response = @conn.post '/start_game'
    response = @conn.post '/game', 'guess=11'
    assert response.body.include?("Your 11 is too")
    assert response.body.include?("Your 11 is too high. Try again")
  end

  def test_computer_returns_player_guess_to_low
    response = @conn.post '/start_game'
    response = @conn.post '/game', 'guess=0'
    assert response.body.include?("Your 0 is too")
    assert response.body.include?("Your 0 is too low. Try agian")
  end

  def test_computer_keeps_track_of_number_of_guesses
    skip
  end

  def test_computer_lets_you_know_when_you_win
    0...11.times{ |x|
      response = @conn.post '/game', "guess=%d" % [x]
      assert_equal "Congratulations" if response.body.include?("Congratulations")
    }
  end


  def test_game_returns_status_code_301_when_no_game_in_progress
    skip
    assert success?
  end

  def test_game_returns_status_code_403_when_new_game_is_attempted_during_game
    skip
    assert success?
  end


  def test_returns_total_number_of_attempted_guess_after_win
    skip
    assert_equal 3, number_of_guesses
  end

  def test_start_game_greets_you_with_Good_Luck
    response = @conn.post '/start_game'
    
    assert response.body.include?("Good luck!")
  end

  def test_game_function_outputs_to_verb_GET
    skip
    assert equal have no idea how to do this test?, path
    end
  end

  def test_game_returns_status_code_200_when_in_play
    skip
    response = @conn.get '/game'
    assert_equal 200, response.status
  end

end
