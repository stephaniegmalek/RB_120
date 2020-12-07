class Card
  include Comparable
  attr_reader :rank, :suit, :value
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = determine_value
  end

  def <=>(other)
    value <=> other.value
  end

  def determine_value
    case rank
    when 'Jack'  then 11
    when 'Queen' then 12
    when 'King'  then 13
    when 'Ace'   then 14
    else         rank
    end
  end

  def to_s
    "The #{rank} of #{suit}"
  end
end

# cards = [Card.new(2, 'Hearts'),
#         Card.new(10, 'Diamonds'),
#         Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#         Card.new(4, 'Diamonds'),
#         Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#         Card.new('Jack', 'Diamonds'),
#         Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#         Card.new(8, 'Clubs'),
#         Card.new(8, 'Spades')]
# puts cards.min.rank == 8
# puts cards.max.rank == 8

# LS Solution

class CardLS
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

# cards = [CardLS.new(2, 'Hearts'),
#         CardLS.new(10, 'Diamonds'),
#         CardLS.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# Further Exploration
class CardFurther
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  SUIT_VALUES = { 'Diamonds' => 1, 'Clubs' => 2, 'Hearts' => 3, 'Spades' => 4 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def suit_value
    SUIT_VALUES.fetch(suit)
  end

  def <=>(other_card)
    return compare_suits(other_card) if same_rank?(other_card)
    value <=> other_card.value
  end

  def same_rank?(other_card)
    rank == other_card.rank
  end

  def compare_suits(other_card)
    suit_value <=> other_card.suit_value
  end
end

# cards = [CardFurther.new(2, 'Hearts'),
#         CardFurther.new(10, 'Diamonds'),
#         CardFurther.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

cards = [CardFurther.new(8, 'Diamonds'),
        CardFurther.new(8, 'Clubs'),
        CardFurther.new(8, 'Spades')]
p cards[0].same_rank?(cards[1])
puts cards.min
puts cards.max