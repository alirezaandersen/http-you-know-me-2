require 'pry'
require './lib/diagnostic'
require './lib/response_code'


module Controller
  include ResponseCodes

  def response_output(params)

    client = params[:client]
    msg = params[:msg] || nil
    location = params[:location] || nil
    response_code = params[:code] || STATUS_OK

    response = msg.nil? ? "" : "<pre>" +  msg + "</pre>"
    time = Time.now.strftime('%I:%M %p on %A, %B %e, %Y')
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 #{response_code}",
      "date: #{time}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"]
    headers.insert(1,"Loction: #{location}") unless location.nil?
      client.puts headers.join("\r\n")
      client.puts output
  end


    def get_diagnostic_str(request)
      request.collect{ |k,v| "#{k}: #{v}" }.join("\n")
    end

end
