require_relative 'controller'
require_relative 'router'

class ViewOutput

  def initialize
    @controller = Controller.new
  end




  def hello(client, counter)
      @controller.response_output(client: client, msg: "Hello World #{counter}")
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
