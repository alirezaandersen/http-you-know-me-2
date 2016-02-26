require './lib/controller'
require './lib/response_code'
require 'pry'

class DebugController

  include Controller
  include ResponseCodes

  def debug(client, request)
    response_output(client: client, msg: "#{request.collect{ |k,v| "#{k}: #{v}" }.join("\n")}")
  end

  def force_error(client,response)
    stack_trace = caller_locations.join("\n")
    response_output(client: client, msg: stack_trace + "\n\n" + get_diagnostic_str(response), code: STATUS_ERROR)
  end

  def not_found(client, request)
    response_output(client: client, msg: STATUS_NOTFOUND + "\n\n" + get_diagnostic_str(request), code: STATUS_NOTFOUND )
  end

end
