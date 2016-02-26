require 'pry'
require 'test_helper'

class GameTest < Minitest::Test

  def setup
    @conn = Faraday.new(url: 'http://127.0.0.1:9292') { |faraday|
      faraday.adapter  Faraday.default_adapter }

    @server = start_server
  end

  def start_server
    @pid = fork do
      server = WebServer.new
      server.loop_server
    end

  end

  def stop_server
    #binding.pry
    Process.kill 9, @pid
  end

  def restart_server
    stop_server
    sleep 1
    start_server
    sleep 2
  end

  def test_content_length_returns_guessed_value
    restart_server
    response = @conn.post '/start_game'
    response = @conn.post '/game', 'guess=11'
    response = @conn.get '/game'
    assert response.body.include?("Your 11 is too")
  end


  def test_computer_returns_player_guess_to_high
    restart_server
    response = @conn.post '/start_game'
    response = @conn.post '/game', 'guess=11'
    response = @conn.get '/game'
    assert response.body.include?("Your 11 is too")
    assert response.body.include?("Your 11 is too high. Try again")
  end

  def test_computer_returns_player_guess_to_low
    restart_server
    response = @conn.post '/start_game'
    response = @conn.post '/game', 'guess=0'
    response = @conn.get '/game'
    assert response.body.include?("Your 0 is too")
    assert response.body.include?("Your 0 is too low. Try agian")
  end

  def test_computer_keeps_track_of_number_of_guesses
    restart_server
    response = @conn.post '/start_game'
    response = @conn.post '/game', 'guess=11'
    response = @conn.post '/game', 'guess=11'
    response = @conn.get '/game'
    assert response.body.include?("That was guess number 2")
  end

  def test_computer_lets_you_know_when_you_win
    restart_server
    @conn.post '/start_game'
    0...11.times{ |x|
      response = @conn.post '/game', "guess=%d" % [x]
      response = @conn.get '/game'
      assert response.body.include?("Congratulations") if response.body.include?("Congratulations")
    }
  end


  def test_game_returns_status_code_301_when_no_game_in_progress
    restart_server
    response = @conn.post '/game'
    assert_equal 301, response.status
  end

  def test_returns_total_number_of_attempted_guess_after_win
    restart_server
    0...11.times{ |x|
      response = @conn.post '/game', "guess=%d" % [x]
      response = @conn.get '/game'
      assert_equal response.body.include?("You guessed the number #{x} correctly!!") if response.body.include?("Congratulations")
    }
  end

  def test_get_start_game
    restart_server
    response = @conn.get '/start_game'
    assert response.body.include?("Please use POST request on /start_game to start a new game")
    assert_equal 401, response.status
  end

  def test_post_start_game_on_already_started_game
    restart_server
    response = @conn.post '/start_game'
    response = @conn.post '/start_game'
    assert response.body.include?("There is already a game in progress")
    assert_equal 403, response.status
  end

  def test_post_start_game_and_greet_with_good_luck_message
    restart_server
    response = @conn.post '/start_game'
    assert response.body.include?("Good Luck!")
    assert_equal 200, response.status
  end


  def test_game_returns_status_code_302_redirect_when_post_to_game
    restart_server
    response = @conn.post '/start_game'
    response = @conn.post '/game', 'guess=11'
    assert_equal 302, response.status
  end

  def test_game_returns_status_code_200_when_in_play
    restart_server
    response = @conn.post '/start_game'
    response = @conn.post '/game', 'guess=11'
    response = @conn.get '/game'
    assert_equal 200, response.status
  end

  def teardown
    stop_server
  end
end
