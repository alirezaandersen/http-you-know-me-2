#require_relative 'date_view'
require_relative 'controller'
require 'pry'

class DateController < Controller

  def datetime(client)
    response_output(client: client, msg: Time.now.strftime('%I:%M %p on %A, %B %e, %Y'))
  end

end
