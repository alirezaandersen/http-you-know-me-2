require 'test_helper'


class ControllerTest < Minitest::Test
  def setup
    @conn = Faraday.new(url: 'http://127.0.0.1:9292') { |faraday|
      faraday.adapter  Faraday.default_adapter }
  end

  def test_hello_controller
  response = @conn.get '/hello'
  assert response.body.include?("Hello World!")
  end

  def test_date_time_controller
    response = @conn.get '/datetime'
    assert response.body.include?("2016")
  end

  def test_debug_controller
    response = @conn.get '/'
    assert response.body.include?("User-Agent")
  end

  def test_word_search_controller
    response = @conn.get '/word_search?word=word&word=never&word=wpoierau'
    assert response.body.include?("a known word")
  end

  def test_game_controller
    response = @conn.post '/start_game'
    assert response.body.include?("/start_game")
  end

end
