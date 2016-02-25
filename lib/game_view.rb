# require_relative 'game_controller'
#
# class GameView
#
#   #include GameController
#
#
#   def initialize
#     @counter = 0
#     @computer_guessed = []
#   end
#
#   def randomizer
#     @computer_guessed.rand(1..10)
#   end
#
#   def start_game(client,request) #refactor for post only.
#     response_output(client: client, msg: "Good Luck! Get Ready to Play!")
#      run_game(client,request)
#     # reset #method
#   end
#
#   def run_game(client,request)
#     binding.pry
#     if ['Verb'] == 'GET'.upcase
#       puts "I made it here"
#       # play_game
#     elsif['Verb'] == 'POST'.upcase
#       puts "LUCKY"
#     else
#       puts "this sucks!!!"
#       # game
#     end
#   end
#
# end
