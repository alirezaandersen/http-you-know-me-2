Controller Test

def test_hello_controller
assert success?
end

def test_date_time_controller
assert success?
end

def test_debug_controller
assert succes?
end

def test_word_search_controller
assert success?
end

def test_game_controller
assert_equal "GameStarted", game_controller
end

def test_shutdown_controller
assert success?
end

OutPuts Test


def test_hello_response_output
  assert_equals "Hello Word! (counter)", hello_controller
end

def test_datetime_redirect
time = Time.now.strftime("%I:%M%p on %A, %B %e, %Y\n\n")
Timecop.freeze(time)
assert_equal time, .datetime_controller
end

def test_shutdown_response_out_put
assert_equal "Total Requests: #total_counter"
end

def test_word_search_resonse_to_case_insensitive
assert_equals "Troll is a known word!", word_search
end

def test_word_search_response_to_valid_word
assert_equal "Learning is a known word!", word_search
end

def test_word_search_response_to_invalid_word
assert_equal "Trollery is NOT a known word!", word_search
end

def test_game_outputs_greeting
assert_equal "Good Luck", game_controller.start_game
end

GameTest

def test_content_length_returns_guessed_value
assert equal 7, game_controller
end

def test_computer_number_generates_random_number
num = 5.times.map do computer_number
assert_equals "num", computer_number
end

def test_computer_returns_player_guess_to_high
assert_equal "Your guess 10 is to high! Try again.", player_guess
end

def test_computer_returns_player_guess_to_low
assert_equal "Your guess 1 is to low! Try again.", player_guess
end

def test computer_keeps_track_of_number_of_guesses
assert_equal 7, number_of_guesses
end

def test_computer_lets_you_know_when_you_win
assert_equal "Congratulations you won! It took you x amount of times to win, player_guess"
end

def test_game_returns_status_code_200_when_in_play
assert success?
end

def test_game_returns_status_code_301_when_no_game_in_progress
assert success?
end

def test_game_returns_status_code_403_when_new_game_is_attempted_during_game
assert success?
end

def test_returns_total_number_of_attempted_guess_after_win
assert_equal 4, number_of_guesses
end

def test_start_game_greets_you_with_Good_Luck
assert_equal "Good luck!\n I'm thinking of a number between 1 to 10", start_game
end

def test_game_function_outputs_to_verb_GET
assert equal have no idea how to do this test?, path
end


ServerCodeTest


def test_server_returns_status_200_for_hello_path
assert_equal "hello word! (counter)", hello_controller
end

def test_server_returns_status_200_for_date_time
assert_equal time = Time.now.strftime("%I:%M%p on %A, %B %e, %Y\n\n")
Timecop.freeze(time), datetime_controller
end

def test_server_returns_status_301_Moved_Permanently
assert success?
end

def test_server_returns_status_401_Unathorized
assert success?
end

def test_server_returns_status_403_Forbidden
assert success?
end

def test_server_returns_status_404_Not_Found
assert success?
end

def test_sever_returns_status_500_Internal_Server_Error
assert success?
end

def test_server_returns_SystemError_exception
assert_equals >>>>>,
end
