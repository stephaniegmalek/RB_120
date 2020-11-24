class Card
  SUITS = ['Heart', 'Spade', 'Clubs', 'Diamond']
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9',
           '10', 'Jack', 'Queen', 'King', 'Ace']

  attr_reader :suit, :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "The #{face} of #{suit}"
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
    puts "---- #{name}'s Hand ----"
    cards.each do |card|
      puts "=> #{card}"
    end
    puts ''
  end

  def add(card)
    cards << card
  end
  
  def busted?
    total > 21
  end
end

class Participant
  include Hand

  attr_accessor :cards, :name

  def initialize
    @cards = []
    set_name
  end
end

class Player < Participant
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
end

class Dealer < Participant
  def set_name
    self.name = 'Robot Dealer'
  end
end

class Game

  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def deal_cards
    2.times do |_|
      player.cards << deck.deal
      dealer.cards << deck.deal
    end
  end



  def player_turn
    loop do
      player_turn = nil
      loop do
        puts "Would you like to (h)it or (s)tay?"
        player_turn = gets.chomp.downcase
        break if ['h', 's'].include?(player_turn)
        puts "Sorry, must enter 'h' or 's'."
      end
  
      player.add(deck.deal) if player_turn == 'h'
  
      break if player_turn == 's' #|| busted?
    end
  end

  def start
    deal_cards
    player.show_hand
    dealer.show_hand


    player_turn
    player.show_hand
    # dealer_turn
    # show_result
  end
end

Game.new.start