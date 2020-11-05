=begin
----- The Object Model -----
Exercises: 

module Speak
  def speak(sound)
    puts sound
  end
end

class Human
  include Speak
end

steph = Human.new
steph.speak("Hola!")

=end

=begin
----- Classes and Objects - Part 1 -----

class GoodDog
  attr_accessor :name, :height, :weight
  
  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end
  
  def speak
    "#{name} says Arf!"
  end
  
  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end
  
  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')

puts sparky.info
sparky.change_info('Spot', '24 inches', '45 lbs')
puts sparky.info
=end
# Exercises
=begin 
1.

class MyCar
  
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
end

lumina = MyCar.new(1996, 'chevy lumina', 'blue')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(10)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_off
lumina.current_speed
=end
# 2.
=begin
class MyCar
  attr_accessor :color
  attr_reader :year
  
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
end

malibu = MyCar.new(1996, 'blue', 'chevy malibu')
puts malibu.color
malibu.color = 'white'
puts malibu.color
puts malibu.year
=end
#3. 

class MyCar
  attr_accessor :color
  attr_reader :year
  
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
end

malibu = MyCar.new(1997, 'blue', 'chevy malibu')
puts malibu.color
malibu.spray_paint('yellow')
puts malibu.color