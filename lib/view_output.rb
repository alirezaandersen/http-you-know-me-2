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
    x = request.select {|key, value| ["Path"].include?(key) } # {"Path"=>"/word_search?word=Troll"}
    a = x.map.with_index { |k,v| k[1] } # ["/word_search?word=Troll"]
    z = a[0] # "/word_search?word=Troll"
    f = z.split("?")[1] #"word=troll&word=trollief"
    n = f.split("&") # ["word=troll", "word=trollief"]
    word1 = n[0].split("=")[1] # "troll"
    word2 = n[1].split("=")[1] # "trollief"

    d = valid_words?([word1,word2])
    @controller.response_output(client: client, msg: d )
  end


  def valid_words?(words)
    puts "IM HERE FINALLY"
    msg = ""
    words.each do |word|
    if dictionary.include?(word.downcase) == true
    msg = msg +  "#{word.upcase} is a known word\n"
   else
    msg = msg +   "#{word.upcase} is not a known word\n"
   end
 end
 msg
 end
 # require 'pry' ;binding.pry

  def dictionary
    File.read('/usr/share/dict/words').split("\n")
 end


 # valid_words?("troll,trollief")

  def force_error(client)

  end

end
