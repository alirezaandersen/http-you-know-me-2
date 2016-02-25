require_relative 'word_search_controller'
require_relative 'response_code'
require 'uri'
require 'pry'

class WordSearchView

  include WordSearchController
  include ResponseCodes

  def word_search(client,request)
    # binding.pry
    if request.nil? or !request['Path'].include?('?')
      response_output(client: client, msg: STATUS_NOTFOUND )
    else
    get_params = request['Path'].split('?')[1]
    words = URI.decode_www_form(get_params).flat_map{|k,v| v}
    #binding.pry
    d = valid_words?(words)
    response_output(client: client, msg: d )
    end
  end

  def word_search2(client,request)
    separate = request.select {|key, value| ["Path"].include?(key) } # {"Path"=>"/word_search?word=Troll"}
    url_array = separate.map.with_index { |k,v| k[1] } # ["/word_search?word=Troll"]
    url_string = url_array[0] # "/word_search?word=Troll"
    first_seperation = url_string.split("?")[1] #"word=troll&word=trollief"
    multiple_strings = first_seperation.split("&") # ["word=troll", "word=trollief"]
    word1 = multiple_strings[0].split("=")[1] # "troll"
    word2 = multiple_strings[1].split("=")[1] # "trollief"

    d = valid_words?([word1,word2])
    response_output(client: client, msg: d )
  end


  def valid_words?(words)

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

  def dictionary
    File.read('/usr/share/dict/words').split("\n")
  end

end