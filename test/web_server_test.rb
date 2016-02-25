require_relative 'test_helper'




class WebServerTest < Minitest::Test
def test_returns_200
  response = Faraday.get 'http://www.cnn.com'
  # require 'pry' ; binding.pry
  assert response.success?
end

def test_returns_301
  response = Faraday.get ''

  assert response.success?
end

def test_returns_302
  response = Faraday.get ''

  assert response.success?
end 




end
