require 'test_helper'


class ControllerTest < Minitest::Test
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

  def test_hello_controller
  restart_server
  response = @conn.get '/hello'
  assert response.body.include?("Hello World!")
  end

  def test_date_time_controller
    restart_server
    response = @conn.get '/datetime'
    assert response.body.include?("2016")
  end

  def test_debug_controller
    restart_server
    response = @conn.get '/'
    assert response.body.include?("User-Agent")
  end

  def test_word_search_controller
    restart_server
    response = @conn.get '/word_search?word=word&word=never&word=wpoierau'
    assert response.body.include?("a known word")
  end

  def test_game_controller
    restart_server
    response = @conn.post '/start_game'
    assert response.body.include?("/start_game")
  end

  def teardown
    stop_server
  end
end
