require_relative 'shutdown_controller'
require 'pry'


class ShutdownView

  include ShutdownController

  def shutdown(client, total_counter)
    response_output(client: client, msg: "Total Request: #{total_counter}")
    exit
  end

end
