require './lib/controller'
require 'pry'

class ShutdownController

  include Controller

  def shutdown(client, total_counter,request)
    response_output(client: client, msg: "Total Request: #{total_counter}" + "\n\n" +  get_diagnostic_str(request) )
    exit
  end

end
