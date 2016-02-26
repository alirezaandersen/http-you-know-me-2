require 'pry'


class Diagnostic


  def parse_request(client)
    request_lines = []
    request = {}
    index = 0
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
      if index == 0
        (request['Verb'],request['Path'],request['Protocol']) = line.chomp.split
      else
        (key,val) = line.chomp.split(': ')
        request[key.strip] = val.strip
      end
      index += 1
    end
    request
  end

end
