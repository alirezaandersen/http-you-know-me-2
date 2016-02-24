require_relative 'controller'
require_relative 'view_output'
# require_relative 'game'
require 'pry'

class Router

  # include ResponseCodes

  def initialize
    @hello_counter = 0
    @total_counter = 0
    @view_output = ViewOutput.new
  end


  def route(client,request)
    @total_counter +=1
    case request['Path']

    when '/'
     @view_output.debug(client, request)

    when '/hello'
      @hello_counter+=1
      @view_output.hello(client,@hello_counter)

    when '/datetime'
      @view_output.datetime(client)

    when '/shutdown'
      @view_output.shutdown(client, @total_counter)
      client.close

    when /^\/word_search*/ #www.http://port/word_search?word=validatingword&word2=validatingword2

      puts "Inside /word_search"
      # binding.pry
      @view_output.word_search(client,request)

    when '/force_error'
      puts "Inside /force_error"
      view_output.force_error #blow_up - runs a bunch of error codes but doesn't shutdown server
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
