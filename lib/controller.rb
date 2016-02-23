require_relative 'view_output'

class Controller

  attr_accessor :counter

  def initialize
    @counter = 0
  end

  def response_output(client)
    puts "Ready for a request"
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end

    puts "Got this request:"
    puts request_lines.inspect
    #our Responder
    puts "Sending response."
    # response = "<pre>" + "Hello World #{@counter}" + "</pre>"
    response = "<pre>" + msg + "</pre>"
    time = Time.now.strftime('%I:%M %p on %A, %B %e, %Y')
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{time}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output
      @counter += 1

      puts ["Wrote this response:", headers, output].join("\n")
      client.close
      puts "\nResponse complete, exiting."

    end
  end
