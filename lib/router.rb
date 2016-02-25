# require_relative 'controller'
require_relative 'output_view'
require_relative 'date_view'
require_relative 'debug_view'
require_relative 'game_view'
require_relative 'hello_view'
require_relative 'shutdown_view'
require_relative 'word_search_view'
require_relative 'diagnostic'
require 'pry'

class Router

  # include ResponseCodes

  def initialize
    @hello_counter = 0
    @total_counter = 0
    # @output_view = OutputView.new
    @date_view = DateView.new
    @debug_view = DebugView.new
    @hello_view = HelloView.new
    @game_view = GameView.new
    @shutdown_view = ShutdownView.new
    @word_search_view = WordSearchView.new
  end


  def route(client,request)
    @total_counter +=1
    case request['Path']

    when '/'
     @debug_view.debug(client, request)

    when '/hello'
      @hello_counter+=1
      @hello_view.hello(client,@hello_counter)

    when '/datetime'
      @date_view.datetime(client)

    when '/shutdown'
      @shutdown_view.shutdown(client, @total_counter)
      client.close

    when /^\/word_search*/
      @word_search_view.word_search(client,request)

    when '/force_error'
      puts "Inside /force_error"
      @debug_view.force_error #blow_up - runs a bunch of error codes but doesn't shutdown server
      #ITERATION 5 easy to add but no worries for right now just raises an exception

    when '/start_game'
      puts "Inside /start_game"
      #game.start_game TBD ITERATION 5
    else
      puts "Inside Else: %s" % [request['Path']]
      # puts "Error message unkown path - USE CONSTANTS"
    end
  end

end
