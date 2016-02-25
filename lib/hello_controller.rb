#require_relative 'hello_view'
require_relative 'controller'
require 'pry'

class HelloController < Controller

  def initialize
    @counter = 0
  end

  def hello(client, request)
    @counter += 1
    response_output(client: client, msg: "Hello World #{@counter}\n\n" + get_diagnostic_str(request) )
  end

end
