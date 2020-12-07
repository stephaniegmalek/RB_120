=begin
guessing game
- pick a random number between 1 and 100
- user gets 7 guesses
- ask user to take a guess 
  - validate user input
- tell user if guess is too high or too low
- repeat until all guesses taken or user gets correct number
  - if user gets correct number
    - they win
  - if run out of guesses
    - they lose
=end

class GuessingGame
  NUMBERS = (1..100).to_a
  MAX_GUESSES = 7

  def initialize
    @guess_number = 0
    @number = NUMBERS.sample
    @user_guess = nil
  end

  def display_guesses_left
    puts "\nYou have #{MAX_GUESSES - @guess_number} guesses remaining."
  end

  def no_more_guesses?
    @guess_number == MAX_GUESSES
  end

  def user_turn
    user_guesses
    @guess_number += 1
  end

  def user_guesses
    answer = nil
    puts "Enter a whole number between 1 and 100:"
    loop do
      answer = gets.chomp
      break if NUMBERS.include?(answer.to_i) && valid_integer?(answer)
      puts "Invalid guess. Enter a whole number between 1 and 100:"
    end
    @user_guess = answer.to_i
  end

  def valid_integer?(input)
    input.to_i.to_s == input
  end

  def determine_results
    if @user_guess < @number
      :too_low
    elsif @user_guess == @number
      :winner
    else
      :too_high
    end
  end

  def display_results
    results = determine_results
    case results
    when :too_low
      puts "Your guess is too low."
    when :winner
      puts "That's the number!"
    when :too_high
      puts "Your guess is too high."
    end
  end

  def winner?
    @user_guess == @number
  end


  def play
    loop do
      display_guesses_left
      user_turn
      display_results
      break if no_more_guesses? || winner?
    end
    
    if winner?
      puts "\nYou won!"
    else
      puts "\nYou have no more guesses. You lost!"
    end
  end
end

# game = GuessingGame.new
# game.play

# LS Solution

class GuessingGameLS
  MAX_GUESSES = 7
  RANGE = 1..100

  RESULT_OF_GUESS_MESSAGE = {
    high: 'Your number is too high.',
    low: 'Your number is too low.',
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high:  :lose,
    low:   :lose,
    match: :win
  }.freeze
  
  RESULT_OF_GAME_MESSAGE = {
    win: 'You won!',
    lose: 'You have no more guesses. You lost!'
  }.freeze
  
  def initialize
    @secret_number = nil
  end
  
  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(RANGE)
  end

  def play_game
    result = nil
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      guess = gets.chomp.to_i
      return guess if RANGE.cover?(guess)
      print "Invalid guess. "
    end
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end

# game2 = GuessingGameLS.new
# game2.play

# Further Exploration
class Player
  def obtain_one_guess
    loop do
      print "Enter a number between #{GuessingGameFurther::RANGE.first} and #{GuessingGameFurther::RANGE.last}: "
      guess = gets.chomp.to_i
      return guess if GuessingGameFurther::RANGE.cover?(guess)
      print "Invalid guess. "
    end
  end
end

class GuessingGameFurther
  MAX_GUESSES = 7
  RANGE = 1..100

  RESULT_OF_GUESS_MESSAGE = {
    high: 'Your number is too high.',
    low: 'Your number is too low.',
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high:  :lose,
    low:   :lose,
    match: :win
  }.freeze
  
  RESULT_OF_GAME_MESSAGE = {
    win: 'You won!',
    lose: 'You have no more guesses. You lost!'
  }.freeze
  
  def initialize
    @secret_number = nil
    @player = Player.new
  end
  
  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(RANGE)
  end

  def play_game
    result = nil
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(@player.obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end

game3 = GuessingGameFurther.new
game3.play