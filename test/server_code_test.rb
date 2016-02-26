require 'test_helper'

class ServerCodeTest < Minitest::Test
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

  def test_client_is_available
    restart_server
    response = @conn.get '/'
    assert response.body.include?("127.0.0.1:9292")
  end

  def test_root_returns_status_200
    restart_server
    response = @conn.get '/'
    assert_equal 200, response.status
  end

  def test_server_returns_status_200_for_hello_path
    restart_server
    response = @conn.get '/hello'
    assert_equal 200, response.status
  end

  def test_server_returns_status_200_for_date_time
    restart_server
    response = @conn.get '/datetime'
    assert_equal 200, response.status
  end


  def test_server_returns_status_404_Not_Found
    restart_server
    response = @conn.post '/g'
    assert_equal 404, response.status
  end

  def test_sever_returns_status_500_Internal_Server_Error
    restart_server
    response = @conn.post '/force_error'
    assert_equal 500, response.status
  end

  def test_server_returns_SystemError_exception
    restart_server
    response = @conn.post '/force_error'
    assert response.body.include?("/Users/alirezaandersen/turing/Module1/homework/http-yeah-you-know-me2/lib/router.rb")
  end

  def test_game_returns_status_code_302_Found
    restart_server
    response = @conn.post '/start_game'
    response = @conn.post '/game', 'guess=11'
    assert_equal 302, response.status
  end

  def test_server_returns_status_403_Forbidden
    restart_server
    response = @conn.post '/start_game'
    response = @conn.post '/game'
    response = @conn.post '/start_game'
    assert_equal 403, response.status
  end

  def test_game_returns_status_code_301_Moved_Permanentely
    restart_server
    response = @conn.post '/game'
    assert_equal 301, response.status
  end

  def teardown
    stop_server
  end
end
