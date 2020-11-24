class Move
  VALUES = {
    'r' => 'rock',
    'p' => 'paper',
    's' => 'scissors',
    'l' => 'lizard',
    'sp' => 'spock'
  }

  attr_reader :value, :loses_to, :wins_against
  
  include Comparable

  def <=>(other_move)
    if self.wins_against.include? other_move.value
      1
    elsif other_move.wins_against.include? self.value
      -1
    else
      0
    end
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = "rock"
    @wins_against = ["scissors", "lizard"]
  end
end

class Paper < Move
  def initialize
    @value = "paper"
    @wins_against = ["rock", "spock"]
  end
end

class Scissors < Move
  def initialize
    @value = "scissors"
    @wins_against = ["paper", "lizard"]
  end
end

class Lizard < Move
  def initialize
    @value = "lizard"
    @wins_against = ["spock", "paper"]
  end
end

class Spock < Move
  def initialize
    @value = "spock"
    @wins_against = ["scissors", "rock"]
  end
end

class History
  attr_reader :moves

  def initialize
    @moves = []
  end

  def add(move)
    @moves << move
  end
end

class Player
  attr_accessor :move, :name, :score, :history, :greeting

  def initialize
    set_name
    @score = 0
    @history = History.new
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp.strip
      break unless n.empty? || !!(n.match(/[^A-Za-z]/))
      puts "Sorry, must enter your name with only alphabetical charaters"
    end
    self.name = n.capitalize
  end

  def player_choices
    puts "\nYou're turn. Please enter:\n"
    Move::VALUES.each do |abr, move|
      puts "- #{abr} or #{move} to choose #{move}"
    end
  end

  def choose
    choice = nil
    loop do
      player_choices
      choice = gets.chomp.downcase
      break if Move::VALUES.to_a.flatten.include? choice
      puts "Sorry, invalid choice. Please try again."
    end
    self.move = RPSGame::MOVES[format_choice(choice)]
    @history.add(move)
  end

  def format_choice(input)
    if Move::VALUES.keys.include? input
      Move::VALUES[input]
    else
      input.downcase
    end
  end
end

class Computer < Player
  COMP_PLAYERS = {
    1 => "R2D2",
    2 => "Jarvis",
    3 => "Ava",
    4 => "Legion"
  }

  def self.display_players
    COMP_PLAYERS.each { |key, player| puts "#{key} - #{player}" }
  end

  def set_name
    self.name = name
  end

  def choose(human_history)
    self.move = make_move(human_history)
    @history.add(move)
  end

  def choose_random
    self.move = RPSGame::MOVES[Move::VALUES.values.sample]
  end
end

class R2D2 < Computer
  def initialize
    @name = 'R2D2'
    @greeting = 'Beep boop beep bop whirr whistl!!'
    super
  end

  def make_move(*)
    choose_random
  end
end

class Jarvis < Computer
  def initialize
    @name = 'Jarvis'
    @greeting = "Hello. Shall we begin?"
    super
  end

  def make_move(*)
    stubborn_move
  end

  private

  def stubborn_move
    if history.moves.empty?
      choose_random
    else
      history.moves.last
    end
  end
end

class Ava < Computer
  def initialize
    @name = 'Ava'
    @greeting = "I'm interested to see what you'll choose."
    super
  end

  def make_move(human_history)
    copycat_move(human_history)
  end

  private

  def copycat_move(human_history)
    if history.moves.empty?
      choose_random
    else
      human_history.moves[-2]
    end
  end
end

class Legion < Computer
  def initialize
    @name = 'Legion'
    @greeting = "You fool, I was built for warfare. Prepare to be destroyed."
    super
  end

  def make_move(human_history)
    counterstrike_move(human_history)
  end

  private

  def counterstrike_move(human_history)
    if history.moves.empty?
      choose_random
    else
      RPSGame::MOVES[human_history.moves[-2].loses_to.sample]
    end
  end
end

module Displayable
  MOVES = Move::VALUES.values.map(&:capitalize)

  def display_welcome_message
    puts "Welcome to #{MOVES.join(', ')} #{human.name}!"
    puts
  end

  def display_rules
    puts <<-MSG
The first player to score 3 points is the grand winner!

Scissors cuts paper, paper covers rock, rock crushes lizard, 
lizard poisons Spock, Spock smashes scissors, scissors decapitates 
lizard, lizard eats paper, paper disproves Spock, Spock vaporizes 
rock, and as it always has, rock crushes scissors.

Good luck!
    MSG
  end

  def display_opponent_greeting
    clear_screen
    puts "\nYou've selected #{computer.name}!"
    puts "\n#{computer.name} says, \"#{computer.greeting}\""
  end

  def display_goodbye_message
    puts "Thanks for playing #{MOVES.join(', ')} #{human.name}. Good bye!"
  end

  def display_moves
    puts "\n#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_history
    clear_screen
    players = [human, computer]
    players.each do |player|
      puts "#{player.name} choose:"
      player.history.moves.each_with_index do |move, idx|
        puts "Round #{idx + 1}: #{move}"
      end
      puts ""
    end
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_scores
    puts "\n#{human.name}'s score is: #{human.score}"
    puts "#{computer.name}'s score is: #{computer.score}"
  end

  def display_grand_winner
    if human.score == 3
      puts "The grand winner is #{human.name}!"
    elsif computer.score == 3
      puts "The grand winner is #{computer.name}!"
    end
  end

  def display_encouragement
    encouragement = [
      "Only need to win #{RPSGame::WINNING_SCORE - human.score} more times!",
      "You got this!",
      "Don't give up now!",
      "Believe in yourself!",
      "You'll get them next time!",
      "You can do it!"
    ]
    puts "\n#{encouragement.sample}"
  end

  def display_kudos
    kudos = [
      "Nailed it!",
      "Keep it up!",
      "Way to go!",
      "Sweet Victory!"
    ]
    puts "\n#{kudos.sample}"
  end
end

class RPSGame
  attr_accessor :human, :computer

  include Displayable

  WINNING_SCORE = 3
  MOVES = {
    "rock" => Rock.new,
    "paper" => Paper.new,
    "scissors" => Scissors.new,
    "lizard" => Lizard.new,
    "spock" => Spock.new
  }

  def initialize
    @human = Human.new
  end

  private

  def clear_screen
    system("cls") || system("clear")
  end

  def start_game
    puts "\nWhen you're ready to start, hit enter"
    gets.chomp
    clear_screen
  end

  def player_pick_opponent
    choice = nil
    loop do
      puts "Pick your opponent:"
      Computer.display_players
      choice = gets.chomp.to_i
      break if Computer::COMP_PLAYERS.keys.include? choice
      puts "Sorry, that's not a valid choice"
    end
    Computer::COMP_PLAYERS[choice]
  end

  def set_opponent
    choice = player_pick_opponent
    @computer = Object.const_get(choice).new
  end

  def setup_opponent
    set_opponent
    display_opponent_greeting
  end

  def players_choose
    human.choose
    computer.choose(human.history)
    clear_screen
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def reset_history
    human.history = History.new
    computer.history = History.new
  end

  def reset_game
    reset_scores
    reset_history
  end

  def compare_moves
    if human.move > computer.move
      human
    elsif human.move < computer.move
      computer
    else
      :tie
    end
  end

  def update_score(player)
    player.score += 1 unless player == :tie
  end

  def grand_winner?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def continue_playing?
    answer = nil
    loop do
      puts "Would you like to continue playing? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must enter either y or n."
    end

    return true if answer == 'y'
    false
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play another round? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be Y or N."
    end

    return true if answer == 'y'
    false
  end

  def show_history?
    answer = nil
    loop do
      puts "Would you like to see the game history? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must enter either y or n"
    end

    return true if answer == 'y'
    false
  end

  def players_move
    players_choose
    display_moves
  end

  def determine_round_results(winner)
    display_winner
    update_score(winner)
    display_scores
  end

  def play_round
    reset_game
    loop do
      players_move
      winner = compare_moves
      determine_round_results(winner)
      break if grand_winner?

      winner == human ? display_kudos : display_encouragement

      break unless continue_playing?
      clear_screen
    end
  end

  def game_intro
    clear_screen
    display_welcome_message
    display_rules
    start_game
  end

  def game_conclusion
    display_history if show_history?
    display_goodbye_message
  end

  public

  def play
    game_intro
    loop do
      setup_opponent
      play_round
      break display_grand_winner if grand_winner?
      break unless play_again?
    end
    game_conclusion
  end
end

RPSGame.new.play
