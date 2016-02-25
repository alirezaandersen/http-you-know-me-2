#require_relative 'debug_view'
require_relative 'controller'
require 'pry'

class DebugController < Controller

  def debug(client, request)
    response_output(client: client, msg: "#{request.collect{ |k,v| "#{k}: #{v}" }.join("\n")}")
  end

  def force_error
  end
  
end
