require './lib/controller'
require './lib/response_code'
require 'pry'

class GameController

  attr_reader :number_of_guesses

  include Controller
  include ResponseCodes

  def initialize
    @start = false
    @computer_answer = computer_number
    @number_of_guesses = 0
    @guess = -1
  end

  def reset
    @start = false
    @computer_answer = computer_number
    @number_of_guesses = 0
    @guess = -1
  end

  def computer_number
    @computer_answer = rand(1..10)
  end

  def start_game(client, request)
    verb = request['Verb']
    if verb.upcase == "POST"
      if @start == true #start game that already exists
        response_output(client: client, msg: "There is already a game in progress\n\n" + get_diagnostic_str(request), code: STATUS_FORB)
      else  #start game that doesn't exist
        @start = true
        response_output(client: client, msg: "Good Luck!\n" "I'm thinking of a number between 1 to 10\n\n" + get_diagnostic_str(request), code: STATUS_REDIRECT)
      end
      game(client,request)
    else
        #unauthorized
    end
  end

  def get_guess(client,request)
    content_length = request["Content-Length"].to_i
    content = client.read(content_length)
    content.split("=")[1].to_i
  end

  def player_guess(client,request)
    @number_of_guesses += 1
    guess = get_guess(client,request)
    guesses(client, request, guess)
  end

  def game(client,request)
    if request['Verb'].upcase == 'POST'
      if @start == false
        response_output(client: client, msg: "Please start game first by going to /start_game\n\n" + get_diagnostic_str(request), code: STATUS_REDIRECT)
      else
        #get guess and process a redirect
        #player_guess(client,request)
        @guess = ge
        response_output(client: client, code: STATUS_MOVED, location: 'http://127.0.0.1:9292/game')
      end
    else #GET Request

      #output:
=begin
a) how many guesses have been taken.
b) if a guess has been made, it tells what the guess was and whether it was too high, too low, or correc
=end

      end
    end

  def guesses(client,request,guess)
    if guess < @computer_answer
      low_guesses(client,request,guess)
    elsif guess > @computer_answer
      high_guesses(client,request,guess)
    else
      correct_guess(client,request)
    end
  end

  def low_guesses(client, request, guess)
    response_output(client: client, msg: "That was guess number #{@number_of_guesses}\n" "Your #{guess} is too low. Try agian\n\n" + get_diagnostic_str(request), status: STATUS_OK)
  end

  def high_guesses(client, request, guess)
    response_output(client: client, msg: "That was guess number #{@number_of_guesses}\n" "Your #{guess} is too high. Try again\n\n" + get_diagnostic_str(request), status: STATUS_OK)
  end

  def correct_guess(client, request)
    result = "#{@number_of_guesses} " + (@number_of_guesses > 1 ? "guesses" : "guess")
    output_str = "You guessed the number #{@computer_answer} correctly!!\n" "It took you #{result} to get it right\n\n"
    reset
    response_output(client: client, msg: output_str + get_diagnostic_str(request), code: STATUS_OK)
  end


end
