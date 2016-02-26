require './lib/controller'
require 'pry'

class DateController
  include Controller

  def datetime(client,request)
    response_output(client: client, msg: Time.now.strftime('%I:%M %p on %A, %B %e, %Y') + "\n\n" +  get_diagnostic_str(request) )
  end

end
