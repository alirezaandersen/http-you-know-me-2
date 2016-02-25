require_relative 'controller'
#require_relative 'game_view'
require 'pry'

class GameController < Controller
  def initialize
    @start = false
    @computer_answer = computer_number
    @location = "POST"
    @number_of_guesses = 0
    @player_guess = []
  end

  def computer_number
    @computer_answer = rand(1..10)
  end

  def start_game(client, request)
    verb = request['Verb']
    if verb.upcase == "POST"
      @start = true
      response_output(client: client, msg: "Good Luck!\n" "I'm thinking of a number between 1 to 10")
      guesses
    end
  end

  def game_in_progress(client, request)
    verb = request['Verb']
    if verb.upcase == "POST"
    else

    end

    # compare the computer gues to the user guess.
  end

  def guesses(client,request)
    @number_of_guesses += 1
    if player_guess < computer_answer
      low_guesses
    elsif player_guess > computer_answer
    high_guesses
    elsif player_guess == computer_answer
    correct_guess
    end
  end

  def low_guesses(client, request)
    response_output(client: client, msg: "That was guess number #{@number_of_guesses}\n" "Your #{player_guess} is too low. Try agian")
  end

  def high_guesses(client, request)
    response_output(client: client, msg: "That was guess number #{@number_of_guesses}\n" "Your #{player_guess} is total_counter high. Try again")
  end

  def correct_guess(client, request)
    result = "#{@number_of_guesses} " + (@number_of_guesses > 1 ? "guesses" : "guess")
    response_output(client: client, msg: "You guessed correctly!!\n" "It took you #{result} to get it right")
  end




end
