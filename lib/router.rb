require_relative 'controller'
require_relative 'view_output'
# require_relative 'game'


class Router

  def initialize
    @hello_counter = 0
    @total_counter = 0
    @view_output = ViewOutput.new
  end


  def route(client,request)
    @total_counter +=1
    case request['Path']
    when '/'
      # view_output
    when '/hello'
      @counter+=1
      @view_output.hello(client,request)
    when '/datetime'
      @view_output.datetime # Time.now.strftime('%I:%M %p on %A, %B %e, %Y')
    when '/shutdown'
      @view_output.shutdown #close_server request total # of times server is processed
      #needs exit code
    when '/^\/word_finder*/'
      @view_output.word_finder # - parses through the dictionary to validate words
    when '/force_error'
      view_output.force_error #blow_up - runs a bunch of error codes but doesn't shutdown server
      #ITERATION 5 easy to add but no worries for right now just raises an exception
    when '/start_game'
      #game.start_game TBD ITERATION 5
    else
      # puts "Error message unkown path - USE CONSTANTS"
    end
  end

end
