class Card
  SUITS = ["\u2663", "\u2662", "\u2661", "\u2660"]
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9',
           '10', 'Jack', 'Queen', 'King', 'Ace']

  attr_reader :suit, :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def ace?
    face == 'Ace'
  end

  def jack?
    face == 'Jack'
  end

  def queen?
    face == 'Queen'
  end

  def king?
    face == 'King'
  end

  def to_s
    "#{face} of #{suit}"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    make_deck
  end

  def make_deck
    Card::SUITS.each do |suit|
      Card::FACES.each { |face| @cards << Card.new(suit, face) }
    end
    cards.shuffle!
  end

  def deal
    cards.pop
  end
end

module Hand
  def show_hand
    puts "\n---- #{name}'s Hand ----"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts ''
  end

  def add(card)
    cards << card
  end

  def total
    values = cards.map do |card|
      if card.ace?
        11
      elsif card.jack? || card.queen? || card.king?
        10
      else
        card.face.to_i
      end
    end

    self.hand_total = adjust_for_aces(values.sum)
  end

  def adjust_for_aces(sum)
    cards.select(&:ace?).count.times do
      sum -= 10 if sum > 21
    end
    sum
  end

  def busted?
    hand_total > 21
  end
end

class Participant
  include Hand

  attr_accessor :cards, :name, :hand_total, :score

  def initialize
    @cards = []
    set_name
    @hand_total = 0
    @score = 0
  end

  def show_total
    puts "=> Total: #{hand_total}"
  end
end

class Player < Participant
  def valid_name?(n)
    !!(n.match(/[^A-Za-z]/))
  end

  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp.strip
      break unless n.empty? || valid_name?(n)
      puts "Sorry, must enter your name with only alphabetical charaters"
    end
    self.name = n.capitalize
  end

  def show_flop
    show_hand
  end

  def choose_to_hit_or_stay
    puts "\nWould you like to (h)it or (s)tay?"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break if ['h', 's'].include?(answer)
      puts "\nSorry, must enter 'h' or 's'."
    end
    answer
  end
end

class Dealer < Participant
  def set_name
    self.name = 'Robot Dealer'
  end

  def show_flop
    puts "\n---- #{name}'s Hand ----"
    puts "=> #{cards.first}"
    puts '=>  ?? '
  end
end

class TwentyOne
  GRAND_WIN = 3

  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  private

  def clear
    system('clear') || system('cls')
  end

  def reset_cards
    self.deck = Deck.new
    player.cards = []
    dealer.cards = []
  end

  def match_reset
    reset_cards
    player.score = 0
    dealer.score = 0
  end

  def deal_cards
    2.times do |_|
      player.add(deck.deal)
      player.total
      dealer.add(deck.deal)
      dealer.total
    end
  end

  def show_flop
    player.show_flop
    player.show_total
    dealer.show_flop
  end

  def show_cards
    player.show_hand
    player.show_total
    dealer.show_hand
    dealer.show_total
  end

  def player_hit
    clear
    puts "\n#{player.name} hits!"
    player.add(deck.deal)
    player.total
    player.show_hand
    player.show_total
  end

  def player_stays
    clear
    puts "\n#{player.name} stays at #{player.hand_total}!"
    player.show_hand
    sleep 3
  end

  def player_plays
    answer = nil
    loop do
      answer = player.choose_to_hit_or_stay
      break if answer == 's'

      player_hit
      break if player.busted?
    end
    player_stays if answer == 's'
  end

  def player_turn
    puts "\n#{player.name}'s turn ..."
    player_plays
  end

  def dealer_stays
    puts "\n#{dealer.name} stays!"
    dealer.show_total
  end

  def dealer_hits
    dealer.add(deck.deal)
    dealer.total
    puts "\n#{dealer.name} hits!"
  end

  def dealer_plays
    loop do
      break dealer_stays if dealer.total >= 17 && !dealer.busted?
      dealer_hits
      break if dealer.busted?
      dealer.show_hand
      dealer.show_total
    end
  end

  def dealer_turn
    clear
    puts "\n#{dealer.name}'s turn..."
    dealer_plays
  end

  def show_busted
    if player.busted?
      puts "\n#{player.name} busted!"
    elsif dealer.busted?
      puts "\n#{dealer.name} busted!"
    end
  end

  def someone_busted?
    player.busted? || dealer.busted?
  end

  def player_win?
    player.hand_total > dealer.hand_total && !player.busted?
  end

  def dealer_win?
    (dealer.hand_total > player.hand_total) && !dealer.busted?
  end

  def determine_match_winner
    if player_win? || dealer.busted?
      :player
    elsif dealer_win? || player.busted?
      :dealer
    else
      :tie
    end
  end

  def show_result(winner)
    case winner
    when :player
      puts "\n#{player.name} wins!"
    when :dealer
      puts "\n#{dealer.name} wins!"
    else
      puts "\nIt's a tie!"
    end
  end

  def update_score(winner)
    case winner
    when :player
      player.score += 1
    when :dealer
      dealer.score += 1
    end
  end

  def grand_winner?
    player.score == GRAND_WIN || dealer.score == GRAND_WIN
  end

  def display_grand_winner
    if player.score == GRAND_WIN
      puts "\n#{player.name} is the grand winner!"
    else
      puts "\n#{dealer.name} is the grand winner!"
    end
  end

  def play_another_hand?
    answer = nil
    loop do
      puts "\nWould you like to play another hand? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "\nSorry, must enter y or n."
    end
    answer == 'y'
  end

  def play_again?
    answer = nil
    loop do
      puts "\nWould you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "\nSorry, must enter y or n."
    end
    answer == 'y'
  end

  def game_intro
    clear
    puts "\nWelcome to Twenty One #{player.name}!"
    puts <<-MSG

The first player to get as close to 21 as possible, without going
over, wins! 

Whoever wins 3 hands, wins the match and is the grand winner!

Good luck!

    MSG
    puts "Press enter to begin."
    gets.chomp
  end

  def match_start
    clear
    deal_cards
    show_flop
  end

  def participants_play
    player_turn
    dealer_turn unless player.busted?
    someone_busted? ? display_busted_match_results : display_results
  end

  def main_game
    loop do
      match_start
      participants_play
      break if grand_winner?

      play_another_hand? ? reset_cards : break
    end
  end

  def display_busted_match_results
    show_busted
    match_results
    display_scores
  end

  def display_scores
    puts "\n#{player.name}'s score: #{player.score}"
    puts "#{dealer.name}'s score: #{dealer.score}"
  end

  def match_results
    winner = determine_match_winner
    show_result(winner)
    update_score(winner)
  end

  def display_results
    sleep 3
    clear
    show_cards
    match_results
    display_scores
  end

  def display_goodbye_message
    puts "\nThanks for playing #{player.name}!! Goodbye."
  end

  def play_game
    loop do
      main_game
      display_grand_winner if grand_winner?
      play_again? ? match_reset : break
    end
  end

  public

  def start
    game_intro
    play_game
    display_goodbye_message
  end
end

game = TwentyOne.new
game.start
