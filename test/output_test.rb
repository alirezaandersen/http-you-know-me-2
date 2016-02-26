require 'test_helper'

class OutPutsTest < Minitest::Test

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

    def test_hello_response_output
      restart_server
      response = @conn.get '/hello'
      assert response.body.include?("Hello World!")
    end

    def test_hello_counter_keeps_track_of_hello_only
      restart_server
      response = @conn.get '/hello'
      response = @conn.get '/hello'
      response = @conn.get '/hello'
      response = @conn.get '/hello'
      response = @conn.get '/hello'
      response = @conn.get '/word_search?word=TroLl&word=alWays'
      response = @conn.get '/hello'
      assert response.body.include?("Hello World! 6")
    end

    def test_validate_time_with_proper_format
      restart_server
      response = @conn.get '/datetime'
      assert_match Time.now.strftime('%I:%M %p on %A, %B %e, %Y'), response.body, " "
      assert_equal 200, response.status
    end

    def test_shutdown_response_out_put
      restart_server
      response = @conn.get '/shutdown'
      assert response.body.include?("Total Request: 1") #total_counter""
    end

    def test_total_requests_of_everything
      restart_server
      response = @conn.get '/datetime'
      response = @conn.get '/datetime'
      response = @conn.get '/datetime'
      response = @conn.get '/datetime'
      response = @conn.get '/datetime'
      response = @conn.get '/datetime'
      response = @conn.get '/datetime'
      response = @conn.get '/shutdown'
      assert response.body.include?("Total Request: 8")
    end

    def test_word_search_resonse_to_case_insensitive
      restart_server
      response = @conn.get '/word_search?word=TroLl&word=alWays'
      assert response.body.include?("ALWAYS is a known word")
    end

    def test_word_search_response_to_valid_word
      restart_server
      response = @conn.get '/word_search?word=Troll'
      assert response.body.include?("TROLL is a known word")
    end

    def test_word_search_response_to_invalid_word
      restart_server
      response = @conn.get '/word_search?word=Trollery'
      assert response.body.include?("TROLLERY is NOT a known word")
    end

    def test_word_search_returns_word_in_upcase
      restart_server
      response = @conn.get '/word_search?word=Zrollerae'
      assert response.body.include?("ZROLLERAE is NOT a known word")
    end

    def test_game_outputs_greeting
      restart_server
      response = @conn.post '/start_game'
      assert response.body.include?("Good Luck")
    end

    def teardown
      stop_server
    end

end
