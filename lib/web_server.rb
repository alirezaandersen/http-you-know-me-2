require 'socket'
require './lib/router'

class WebServer

  def initialize
    @router = Router.new
    @dio = Diagnostic.new
  end

  def loop_server
    tcp_server = TCPServer.new(9292)
    loop  do
      client = tcp_server.accept
      request = @dio.parse_request(client)
      @router.route(client,request)
      client.close

    end
  end

end
