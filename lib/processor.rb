require_relative 'responder'
require_relative 'output_path'
require_relative 'game'


class Processor

  def initialize
    @hello_counter = 0
    @total_counter = 0
  end

  def process(client)
    @total_counter +=1
    case(client)
    when '/'
      # output_path
    when '/hello'
      @counter+=1
      # output_path.hello path and number of times only hello is processed
    when '/datetime'
      #output_path.datetime Time.now.strftime('%I:%M %p on %A, %B %e, %Y')
    when '/shutdown'
      #output_path.close_server request total # of times server is processed
      #needs exit code
    when '/^\/word_finder*/'
      #output_path.word_finder - parses through the dictionary to validate words
    when '/force_error'
      #output_path.blow_up - runs a bunch of error codes but doesn't shutdown server
      #ITERATION 5 easy to add but no worries for right now just raises an exception
    when '/start_game'
      #game.start_game TBD ITERATION 5
    else
      # puts "Error message unkown path - USE CONSTANTS"
    end
  end

end


# If they request the root, aka /, respond with just the debug info from Iteration 1.
# If they request /hello, respond with "Hello, World! (0)"
#   where the 0 increments each time the path is requested, but not when any other path is requested.
# If they request /datetime, respond with
#   today's date and time in this format: 11:07AM on
#   Sunday, November 1, 2015.
#   If they request /shutdown, respond with
#   "Total Requests: 12" where 12 is the aggregate of
#   all requests. It also causes the server to exit / stop
#   serving requests.
