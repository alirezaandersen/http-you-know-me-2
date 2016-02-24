require 'socket'
require_relative 'controller'
require_relative 'router'

class WebServer

  def initialize
    @controller = Controller.new
    @router = Router.new
  end

  def loop_server
    #server - this does a loop
    tcp_server = TCPServer.new(9292)
    loop  do
      client = tcp_server.accept
      @router.route(client)
      #@router.route(client,request)
      #@controller.response_output(client) # default

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
