require 'pry'
require_relative 'diagnostic'
require_relative 'response_code'


class Controller
  include ResponseCodes

  def response_output(params)

    client = params[:client]
    msg = params[:msg]
    response_code = params[:code] || STATUS_OK
    
    response = "<pre>" +  msg + "</pre>"
    time = Time.now.strftime('%I:%M %p on %A, %B %e, %Y')
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 #{response_code}",
      "date: #{time}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output

      # puts ["Wrote this response:", headers, output].join("\n")
      client.close
      # puts "\nResponse complete, exiting."
  end

  def get_diagnostic_str(request)
    request.collect{ |k,v| "#{k}: #{v}" }.join("\n")
  end
end
