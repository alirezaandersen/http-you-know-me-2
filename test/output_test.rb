require 'test_helper'

class OutPutsTest < Minitest::Test

  def setup
    @conn = Faraday.new(url: 'http://127.0.0.1:9292') { |faraday|
      faraday.adapter  Faraday.default_adapter }
  end


  def test_hello_response_output
    skip
    assert_equals "Hello Word! (counter)", hello_controller
  end

  def test_diagnostic_output
    skip
    controller = Controller.new
    binding.pry
    request = {"Verb"=>"POST",
      "Path"=>"/hello",
      "Protocol"=>"HTTP/1.1",
      "Host"=>"127.0.0.1:9292",
      "Connection"=>"keep-alive",
      "Content-Length"=>"7",
      "Cache-Control"=>"no-cache",
      "Origin"=>"chrome-extension://fhbjgbiflinjbdggehcddcbncdddomop",
      "Content-Type"=>"application/x-www-form-urlencoded",
      "User-Agent"=>
      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.116 Safari/537.36",
      "Postman-Token"=>"8d8844a7-d980-1647-5858-c65a77c700e1",
      "Accept"=>"*/*",
      "DNT"=>"1",
      "Accept-Encoding"=>"gzip, deflate",
      "Accept-Language"=>"en-US,en;q=0.8"}
      assert_equal request.join("\n"), controller.get_diagnostic_str(request)
  end

  def test_validate_time_with_proper_format
     response = @conn.get '/datetime'
     assert_match Time.now.strftime('%I:%M %p on %A, %B %e, %Y'), response.body, " "
     assert_equal 200, response.status
   end

    def test_datetime_redirect
      skip
      response = @conn.get '/datetime'
      time = Time.now.strftime("%I:%M%p on %A, %B %e, %Y\n\n")
      Timecop.freeze(time)
      assert_equal time, datetime_controller
    end
  #
  #   def test_shutdown_response_out_put
  #     skip
  #     assert_equal "Total Requests: #total_counter"
  #   end
  #
  #   def test_word_search_resonse_to_case_insensitive
  #     skip
  #     assert_equals "Troll is a known word!", word_search
  #   end
  #
  #   def test_word_search_response_to_valid_word
  #     skip
  #     assert_equal "Learning is a known word!", word_search
  #   end
  #
  #   def test_word_search_response_to_invalid_word
  #     skip
  #     assert_equal "Trollery is NOT a known word!", word_search
  #   end
  #
  #   def test_game_outputs_greeting
  #     skip
  #     assert_equal "Good Luck", game_controller.start_game
  #   end
  #
  # end
end
