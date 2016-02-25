require_relative 'hello_view'
require 'pry'

module HelloController

  def response_output(params)
    client = params[:client]
    msg = params[:msg]

    response = "<pre>" +  msg + "</pre>"
    time = Time.now.strftime('%I:%M %p on %A, %B %e, %Y')
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{time}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output

      # puts ["Wrote this response:", headers, output].join("\n")
      
      # puts "\nResponse complete, exiting."
    end
end
