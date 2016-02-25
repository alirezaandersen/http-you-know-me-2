require_relative 'controller'
require_relative 'response_code'
require 'pry'



class GameController < Controller

  include ResponseCodes

  def initialize
    @start = false
    @computer_answer = computer_number
    @number_of_guesses = 0
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
    else
      game(client,request)

    end
  end

  def player_guess(client,request)
    @number_of_guesses += 1
    content_length = request["Content-Length"].to_i
    content = client.read(content_length)
    guess = content.split("=")[1].to_i
    guesses(client, request, guess)
  end

  def game(client,request)
    if @start == false
      response_output(client: client, msg: "Please start game first by going to /start_game\n\n" + get_diagnostic_str(request), code: STATUS_REDIRECT)
    else
      player_guess(client,request)
    end

  end

  # def game_in_progress(client, request)
  #   @start = true
  #   verb = request['Verb']
  #   if verb.upcase == "POST"
  #   else
  #     puts STATUS_FORB, "Error Message"
  #
  #   end

    # compare the computer gues to the user guess.
  # end

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
    response_output(client: client, msg: "That was guess number #{@number_of_guesses}\n" "Your #{guess} is too low. Try agian\n\n" + get_diagnostic_str(request))
  end

  def high_guesses(client, request, guess)
    response_output(client: client, msg: "That was guess number #{@number_of_guesses}\n" "Your #{guess} is too high. Try again\n\n" + get_diagnostic_str(request))
  end

  def correct_guess(client, request)
    result = "#{@number_of_guesses} " + (@number_of_guesses > 1 ? "guesses" : "guess")
    response_output(client: client, msg: "You guessed the number #{@computer_answer} correctly!!\n" "It took you #{result} to get it right\n\n" + get_diagnostic_str(request))
  end




end
