require_relative 'date_controller'
require_relative 'debug_controller'
require_relative 'game_controller'
require_relative 'hello_controller'
require_relative 'shutdown_controller'
require_relative 'word_search_controller'
require_relative 'diagnostic'
require 'pry'

class Router

  def initialize
    @total_counter = 0
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
    when '/force_error' then @debug_controller.force_error(client,request)
    when '/start_game' then @game_controller.start_game(client,request)
    when '/game' then @game_controller.game(client, request)
    when '/new_game' then  @game_controller.new_game(client, request)
    else @debug_controller.not_found(client, request)

    end
  end

end
