require_relative 'game_controller'

class GameView

  include GameController


  def initialize
    @counter = 0
    @computer_guessed = []
  end

  def randomizer
    @computer_guessed.rand(1..10)
  end

  def start_game(client) #refactor for post only.
    response_output(client: client, msg: "Good Luck! Get Ready to Play!")
    # run_game # method
    # reset #method
  end

  def run_game(client, request)

  end



end
