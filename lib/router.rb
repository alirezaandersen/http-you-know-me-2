require_relative 'controller'
require_relative 'view_output'
# require_relative 'game'
require 'pry';

class Router

  # include ResponseCodes



  def initialize
    @hello_counter = 0
    @total_counter = 0
    @view_output = ViewOutput.new
  end


  def route(client)

    request_lines = []
    request = {}
    index = 0
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
      #  binding.pry
      if index == 0
        (request['Verb'],request['Path'],request['Protocol']) = line.chomp.split
      else
        (key,val) = line.chomp.split(': ')
        request[key.strip] = val.strip
      end
      index += 1
    end
    # binding.pry
    @total_counter +=1
    case request['Path']
    when '/'
    #   puts "Inside /"
     @view_output.debug(client, request)

    when '/hello'
      puts "Inside /hello"
      @hello_counter+=1
      @view_output.hello(client,@hello_counter)

    when '/datetime'
      puts "Inside /datetime"
      @view_output.datetime(client)

    when '/shutdown'
      puts "Inside /shutdown"
      @view_output.shutdown(client, @total_counter)
      client.close

    when '/word_finder' #
      puts "Inside /word_finder"
      #@view_output.word_finder # - parses through the dictionary to validate words

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
