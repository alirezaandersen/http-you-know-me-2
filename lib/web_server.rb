require 'socket'
require_relative 'controller'

class WebServer

  def initialize
    @responder = Controller.new
  end

  def loop_server
    #server - this does a loop
    tcp_server = TCPServer.new(9292)
    loop  do
      client = tcp_server.accept
      @responder.response_output(client)

    end
  end

end

server = WebServer.new
server.loop_server

#
# lib_folder = File.expand_path(__dir__)
# $LOAD_PATH << lib_folder
#
# google set lib fold path
