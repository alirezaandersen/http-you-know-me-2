require 'cgi'
require_relative 'controller'
require_relative 'router'
require_relative 'diagnostic'


class ViewOutput

  attr_accessor :dio

  def initialize
    @controller = Controller.new
    @dio = Diagnostic.new
  end


  def hello(client, counter)
      @controller.response_output(client: client, msg: "Hello World #{counter}")
  end

  def datetime(client)
      @controller.response_output(client: client, msg: Time.now.strftime('%I:%M %p on %A, %B %e, %Y'))
  end

  def debug(client, request)
    @controller.response_output(client: client, msg: "#{request.collect{ |k,v| "#{k}: #{v}" }.join("\n")}")
  end

  def shutdown(client, total_counter)
    @controller.response_output(client: client, msg: "Total Request: #{total_counter}")
    exit
  end

  def word_search(client,request)
    puts "what!"
    require 'pry' ;binding.pry
    request = CGI::parse ('word1=value1&word2=value2')
    puts "REALLY??!!"
    File.open("/usr/share/dict/words") do |file|
      file.each do |line|
        words[line.strip] = true
      end
    end
  end


  def force_error(client)

  end

end
