#require_relative 'shutdown_view'
require_relative 'controller'
require 'pry'

class ShutdownController < Controller

  def shutdown(client, total_counter)
    response_output(client: client, msg: "Total Request: #{total_counter}")
    exit
  end

end
