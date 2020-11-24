# Question 1
class BankAccount
  attr_reader :balance
  
  def initialize(starting_balance)
    @balance = starting_balance
  end
  
  def positive_balance?
    balance >= 0
  end
end

# Question 2
class InvoiceEntry
  attr_reader :quantity, :product_name
  
  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end
  
  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# to fix can either make att_accessor and change quantity to self.quantity or 
# at @ to quantity in method

# Question 3
# is there any issue with fixing the above code with the first solution?
# syntactiacally no - but it removes the protections built into the update_quantity
# method b/c now the quantities can be changed directly 

# Question 4
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# Question 5
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
  
  def to_s
    filling_string = @filling_type ? @filling_type : "Plain"
    glazing_string = @glazing ? " with #{@glazing}" : ""
    filling_string + glazing_string
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

# puts donut1
# # "Plain"
# puts donut2
# # Vanilla
# puts donut3
# # Plain with sugar
# puts donut4
# # Plain with chocolate sprinkles
# puts donut5
# # custard with icing

# Question 6
# code works in same in both but convenstion says to avoid using `self` where not needed

# Question 7
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

# remove light from method name - when called will be Light.light_status - the 2 light is redundant
  def self.status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end

