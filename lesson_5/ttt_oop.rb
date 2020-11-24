class Board
  attr_reader :squares

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts '     |     |'
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts '     |     |'
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      return squares.first.marker if three_same_markers?(squares)
    end
    nil
  end

  def square_five_unmarked?
    @squares[5].marker == Square::INITAL_MARKER
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  private

  def include_marker(squares, marker)
    squares.map(&:marker).include?(marker)
  end

  def three_same_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3

    markers.min == markers.max
  end

  def two_same_markers?(squares, marker)
    squares.collect(&:marker).count(marker) == 2
  end
end

class Square
  INITAL_MARKER = ' '.freeze

  attr_accessor :marker

  def initialize(marker = INITAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITAL_MARKER
  end

  def marked?
    marker != INITAL_MARKER
  end
end

module Displayable
  def clear
    system('cls') || system('clear')
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_rules
    puts <<-MSG
The first player to get 3 of their marks in a row (up, 
down, across, or diagonally) is the winner.

Win 3 games to be crowned the grand winner!

Good luck!
    MSG
  end

  def display_score
    puts "#{human.name}'s score is: #{human.score}."
    puts "#{computer.name}'s score is: #{computer.score}."
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_grand_winner
    if human.score == TTTGame::WINNING_SCORE
      puts "#{human.name} is the grand winner!"
    elsif computer.score == TTTGame::WINNING_SCORE
      puts "#{computer.name} is the grand winner!"
    end
  end

  def display_support
    support = [
      'You got this!',
      "Don't give up now!",
      'Believe in yourself!',
      "You'll get them next time!"
    ]
    puts "\n#{support.sample}"
  end

  def display_kudos
    kudos = [
      'Nailed it!',
      'Keep it up!',
      'Way to go!',
      'Sweet Victory!'
    ]
    puts "\n#{kudos.sample}"
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe #{human.name}! Goodbye!"
  end
end

class Player
  MARKER_OPTIONS = {
    1 => 'X', 2 => 'O', 3 => '!',
    4 => '#', 5 => '+', 6 => '@'
  }.freeze

  attr_accessor :score, :name, :marker
  attr_reader :board

  @@taken_markers = []

  def initialize(board)
    set_name
    @marker = set_marker
    @@taken_markers << marker
    @score = 0
    @board = board
  end

  def display_marker_options
    MARKER_OPTIONS.each do |key, marker|
      puts "#{key}: #{marker}"
    end
  end

  def self.taken_markers
    @@taken_markers
  end

  def valid_integer?(input)
    input.to_i.to_s == input
  end
end

class Human < Player
  include Displayable

  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp.strip
      break unless n.empty? || !!(n.match(/[^A-Za-z]/))

      puts 'Sorry, must enter your name with only alphabetical charaters'
    end
    @name = n.capitalize
  end

  def set_marker
    clear
    m = nil
    loop do
      puts "Please select your marker #{@name}:"
      display_marker_options
      m = gets.chomp
      break if (1..6).to_a.include?(m.to_i) && valid_integer?(m)
      puts 'Sorry. Not a valid choice, try again.'
    end
    MARKER_OPTIONS[m.to_i]
  end

  def joinor(array, delimiter = ', ', word = 'or')
    case array.size
    when 0 then ''
    when 1 then array.join
    when 2 then array.join(" #{word} ")
    else
      array[-1] = "#{word} #{array.last}"
      array.join(delimiter)
    end
  end

  def moves
    puts "Choose a square: #{joinor(board.unmarked_keys)}"
    square = nil
    loop do
      square = gets.chomp
      break if board.unmarked_keys.include?(square.to_i) &&
               valid_integer?(square)

      puts "Sorry, that's not a valid choice."
    end

    board[square.to_i] = marker
  end
end

class Computer < Player
  COMPUTER_NAMES = ['Bot', 'Super Computer', 'BB8', 'Jarvis', 'Skynet'].freeze

  def set_name
    @name = COMPUTER_NAMES.sample
  end

  def set_marker
    @marker = available_markers_to_computer.sample
  end

  def strategy
    offense_strategy = offense_select_square
    defense_strategy = defense_select_square

    if offense_strategy
      board[offense_strategy] = marker
    elsif defense_strategy
      board[defense_strategy] = marker
    else
      board[board.unmarked_keys.sample] = marker
    end
  end

  def moves
    if board.square_five_unmarked?
      board[5] = marker
    else
      strategy
    end
  end

  def available_markers_to_computer
    MARKER_OPTIONS.values - @@taken_markers
  end

  def player_marker
    @@taken_markers[0]
  end

  def defense_select_square
    Board::WINNING_LINES.each do |line|
      row = board.squares.values_at(*line)
      markers = row.map(&:marker)
      if markers.include?(player_marker) && markers.count(player_marker) == 2
        return board.squares.key(row.select(&:unmarked?).first)
      end
    end
    nil
  end

  def offense_select_square
    Board::WINNING_LINES.each do |line|
      row = board.squares.values_at(*line)
      markers = row.map(&:marker)
      if markers.include?(marker) &&
         markers.count(marker) == 2
        return board.squares.key(row.select(&:unmarked?).first)
      end
    end
    nil
  end
end

class TTTGame
  include Displayable

  WINNING_SCORE = 3

  attr_reader :board, :human, :computer
  attr_accessor :current_player

  def initialize
    @board = Board.new
  end

  private

  def game_intro
    clear
    display_welcome_message
    display_rules
    start_game
    set_up_game
    clear
  end

  def start_game
    puts "\nWhen you're ready to start, hit enter"
    gets.chomp
    clear
  end

  def set_up_game
    @human = Human.new(board)
    @computer = Computer.new(board)
    select_first_player
    @current_player = @first_player
  end

  def choose_first_player
    answer = nil
    puts "Please choose who goes first #{human.name}:"
    puts "Enter 'P' for Player (that's you) or 'C' for Computer"
    loop do
      answer = gets.chomp.downcase
      break if answer == 'p' || answer == 'c'

      puts 'Whoops - invalid choice! Please try again.'
    end
    return 'Player' if answer == 'p'
    return 'Computer' if answer == 'c'
  end

  def select_first_player
    clear
    choice = choose_first_player
    case choice
    when 'Player'
      @first_player = human
    when 'Computer'
      @first_player = computer
    end
  end

  def display_board
    puts "You're a(n): #{human.marker}"
    puts "#{computer.name}'s a(n): #{computer.marker}"
    puts ''
    display_score
    puts ''
    board.draw
    puts ''
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def players_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?

      clear_screen_and_display_board if human_turn?
    end
  end

  def current_player_moves
    if human_turn?
      puts "You're turn!"
      puts ''
      human.moves
    else
      computer.moves
    end
    alternate_player
  end

  def human_turn?
    @current_player == human
  end

  def alternate_player
    self.current_player = if current_player == human
                            computer
                          else
                            human
                          end
  end

  def update_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def grand_winner?
    human.score == WINNING_SCORE || computer.score == WINNING_SCORE
  end

  def play_game_again?
    answer = nil
    loop do
      puts ''
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer

      puts 'Sorry, must select y or n'
    end
    answer == 'y'
  end

  def play_round_again?
    answer = nil
    loop do
      puts ''
      puts 'Would you like to play another round? (y/n)'
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts 'Sorry, must select y or n'
    end
    answer == 'y'
  end

  def round_reset
    reset_scores
    reset
  end

  def reset
    board.reset
    @current_player = @first_player
    clear
  end

  def reset_scores
    human.score = 0
    computer.score = 0
  end

  def game_round
    display_board
    players_move
    display_result
    update_score
  end

  def main_game
    loop do
      game_round
      break if grand_winner?
      board.winning_marker == human.marker ? display_kudos : display_support
      break unless play_game_again?
      reset
    end
    display_grand_winner
  end

  public

  def play
    game_intro
    loop do
      main_game
      break unless play_round_again?
      round_reset
    end
    display_goodbye_message
  end
end

TTTGame.new.play
