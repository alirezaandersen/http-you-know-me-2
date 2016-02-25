require_relative 'date_controller'
require 'pry'

class DateView

  include DateController

  def datetime(client)
    response_output(client: client, msg: Time.now.strftime('%I:%M %p on %A, %B %e, %Y'))
  end
end
