require_relative 'view_output'


class Diagnostic




def detect_info(client)
  puts "hello"
request_lines = []
puts "I said Hello"
puts "Helo"

while line = client.gets and !line.chomp.empty?
  request_lines << line.chomp
end

puts "Hellllo?"
puts request_lines.inspect
puts request_lines.join("\n")
end


end
