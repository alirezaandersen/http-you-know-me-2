require_relative 'controller'
require_relative 'router'

class ViewOutput


  def hello(client, request)
      response(client, "Hello World #{request}")
  end


  def datetime(client)
      response(client, Time.now.strftime('%I:%M %p on %A, %B %e, %Y'))
  end

  def debug(client)

  end

  def shutdown(client)
    #needs total_counter
    exit
  end

  def word_finder(client)

  end

  def force_error(client)

  end


  def parser
    parse the particular method into the controller response
  end

end
