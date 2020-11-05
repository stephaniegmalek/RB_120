# Classes and Objects - Part 2
=begin
class GoodDog
  @@number_of_dogs = 0
  
  def initialize
    @@number_of_dogs += 1
  end
  
  def self.total_number_of_dogs
    @@number_of_dogs
  end
  
end

puts GoodDog.total_number_of_dogs

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs
puts dog1
p dog2
=end
=begin
class GoodDog
  DOG_YEARS = 7
  
  attr_accessor :name, :age
  
  def initialize(n, a)
    @name = n
    @age = a * DOG_YEARS
  end
  
  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end

sparky = GoodDog.new("Sparky", 4)
p sparky
puts sparky.inspect
=end
=begin
class GoodDog
  attr_accessor :name, :height, :weight
  
  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end
  
  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end
  
  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
  
  def what_is_self
    self
  end
  
  puts self
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
=end
# Exercise 1

class MyCar
  attr_accessor :year, :color, :model
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end
  
  def speed_up(number)
    @speed += number
    puts "You push the gas and accelerate to #{number} mph."
  end
  
  def brake(number)
    @speed -= number
    puts "You hit the brakes and deaccelerate to #{number} mph."
  end
  
  def current_speed
    puts "You are now going #{@speed} mph."
  end
  
  def shut_off
    @speed = 0
    puts "Let's park it!"
  end
  
  def spray_paint(c)
    self.color = c
    puts "Your new #{c} paint job looks great!"
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
  
  def to_s
    "This car is a #{self.color} #{self.year} #{self.model}."
  end
end

MyCar.gas_mileage(13, 351)
malibu = MyCar.new(1997, 'blue', 'chevy malibu')
puts malibu