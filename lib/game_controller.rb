require_relative 'controller'
#require_relative 'game_view'
require 'pry'

class GameController < Controller
  def initialize
    @start = false
    @computer_guess
  end

  def computers_number
    @computer_guess = rand(1..10)
  end

  def start_game(client, request)
    verb = request['Verb']
    if verb.upcase == "POST"
      @start = true
      response_output(client: client, msg: "Good Luck!")
    end
  end

  def game(client, request)
    verb = request['Verb']
    if verb.upcase == "GET"
      binding.pry
      # response_output(client: client, msg: "I'm thinking of a number between")
    else

    end

    # compare the computer gues to the user guess.
  end


=begin
  def response_output(params)
    client = params[:client]
    msg = params[:msg]

    response = "<pre>" +  msg + "</pre>"
    time = Time.now.strftime('%I:%M %p on %A, %B %e, %Y')
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{time}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output

      # puts ["Wrote this response:", headers, output].join("\n")

      # puts "\nResponse complete, exiting."
    end
=end
end
