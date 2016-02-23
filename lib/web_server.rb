require 'socket'
require_relative 'controller'

class WebServer

  def initialize
    @responder = Responder.new
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
