require './lib/controller'
require 'uri'
require 'pry'

class WordSearchController

  include Controller

  def word_search(client,request)
    if request.nil? or !request['Path'].include?('?')
      response_output(client: client, msg: STATUS_NOTFOUND )
    else
      get_params = request['Path'].split('?')[1]
      words = URI.decode_www_form(get_params).flat_map{|k,v| v}
      d = valid_words?(words)
      response_output(client: client, msg: d + "\n\n" +  get_diagnostic_str(request))
    end
  end

  def valid_words?(words)
    msg = ""
    words.each do |word|
      if dictionary.include?(word.downcase) == true
        msg = msg +  "#{word.upcase} is a known word\n"
      else
        msg = msg +   "#{word.upcase} is NOT a known word\n"
      end
    end
    msg
  end

  def dictionary
    File.read('/usr/share/dict/words').split("\n")
  end

end
