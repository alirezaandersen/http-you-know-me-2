# require_relative 'controller'
# require_relative 'output_controller'
require_relative 'date_controller'
require_relative 'debug_controller'
require_relative 'game_controller'
require_relative 'hello_controller'
require_relative 'shutdown_controller'
require_relative 'word_search_controller'
require_relative 'diagnostic'
require 'pry'

class Router

  # include ResponseCodes

  def initialize
    @total_counter = 0
    # @output_view = OutputController.new
    @date_controller = DateController.new
    @debug_controller = DebugController.new
    @hello_controller = HelloController.new
    @game_controller = GameController.new
    @shutdown_controller = ShutdownController.new
    @word_search_controller = WordSearchController.new
  end


  def route(client,request)
    @total_counter +=1
    case request['Path']
    when '/' then @debug_controller.debug(client, request)
    when '/hello' then @hello_controller.hello(client, request)
    when '/datetime' then @date_controller.datetime(client,request)
    when '/shutdown' then @shutdown_controller.shutdown(client, @total_counter, request)
    when /^\/word_search*/ then @word_search_controller.word_search(client,request)
    when '/force_error' then @debug_controller.force_error #blow_up -
      #NEEDS TO RESPONSE WITH SYSTM ERROR
    when '/start_game' then @game_controller.start_game(client,request)
    when '/game' then @game_controller.game(client, request)
    when '/new_game' then  @game_controller.new_game(client, request)
    else
      puts "Inside Else: %s" % [request['Path']]
      # puts "Error message unkown path - "STATUS_NOTFOUND"
      #If server generators an error -NEEDS TO RESPONSE WITH "STATUS ERROR"
    end
  end

end
