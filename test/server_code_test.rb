require 'test_helper'

class ServerCodeTest < Minitest::Test
  # def setup
  #   start_server
  # end
  #
  # def start_server
  #   $server = Thread.new do
  #     require './lib/web_server'
  #   end|
  # end
  #
  # def stop_server
  #   $server.kill if $server
  # end
  #
  # def restart_server
  #   stop_server
  #   start_server
  # end
  def setup
    @conn = Faraday.new(url: 'http://127.0.0.1:9292') { |faraday|
      faraday.adapter  Faraday.default_adapter }
  end

  def test_client_is_available
    response = @conn.get '/'
    assert response.body.include?("127.0.0.1:9292")
  end

  def test_root_returns_status_200
    response = @conn.get '/'
    assert_equal 200, response.status
  end

  def test_server_returns_status_200_for_hello_path
    response = @conn.get '/hello'
    assert_equal 200, response.status
  end

  def test_server_returns_status_200_for_date_time
    response = @conn.get '/datetime'
    assert_equal 200, response.status
  end


  def test_server_returns_status_404_Not_Found
    response = @conn.post '/g'
    assert_equal 404, response.status
  end

  def test_sever_returns_status_500_Internal_Server_Error
    response = @conn.post '/force_error'
    assert_equal 500, response.status
  end

  def test_server_returns_SystemError_exception
    response = @conn.post '/force_error'
    assert response.body.include?("/Users/alirezaandersen/turing/Module1/homework/http-yeah-you-know-me2/lib/router.rb")
  end

  def test_server_returns_status_301_Moved_Permanently
    skip
    response = @conn.post '/game'
    assert_equal 301, response.status
  end

  def test_server_returns_status_403_Forbidden
    skip
    response = @conn.post '/start_game'
    assert_equal 301, response.status

    response = @conn.post '/start_game'
    assert_equal 403, response.status
  end


end
