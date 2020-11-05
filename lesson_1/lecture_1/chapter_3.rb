# Class Inheritance

# class Animal
#   attr_accessor :name
  
#   def initialize(name)
#     @name = name
#   end
# end

# class GoodDog < Animal
#   def initialize(color)
#     super
#     @color = color
#   end
# end

# class Cat < Animal
# end

# class BadDog < Animal
#   def initialize(age, name)
#     super(name)
#     @age = age
#   end
# end

# p bruno = GoodDog.new("brown")
# p BadDog.new(2, 'bear')

# Mixin Modules

# module Swimmable
#   def swim
#     "I'm swimming!"
#   end
# end

# class Animal; end

# class Fish < Animal
#   include Swimmable
# end

# class Mammal < Animal
# end

# class Cat < Mammal
# end

# class Dog < Mammal
#   include Swimmable
# end

# sparky = Dog.new
# neemo = Fish.new
# paws = Cat.new

# puts sparky.swim
# puts neemo.swim
# paws.swim

# Method Lookup Path

# module Walkable
#   def walk
#     "I'm walking."
#   end
# end

# module Swimmable
#   def swim
#     "I'm swimming."
#   end
# end

# module Climbable
#   def climb
#     "I'm climbing."
#   end
# end

# class Animal
#   include Walkable
  
#   def speak
#     "I'm an animal, and I speak!"
#   end
# end

# class GoodDog < Animal
#   include Swimmable
#   include Climbable
# end

# puts "-----GoodDog method lookup-----"
# puts GoodDog.ancestors

# More Modules

# module Mammal
#   class Dog
#     def speak(sound)
#       p "#{sound}"
#     end
#   end
  
#   class Cat
#     def say_name(name)
#       p "#{name}"
#     end
#   end
  
#   def self.some_out_of_place_method(num)
#     num ** 2
#   end
# end

# buddy = Mammal::Dog.new
# kitty = Mammal::Cat.new
# buddy.speak('Arf!')
# kitty.say_name('kitty')

# p value = Mammal.some_out_of_place_method(4)
# p v = Mammal::some_out_of_place_method(4)

# Private, Protected and Public Methods

# class GoodDog
#   DOG_YEARS = 7
  
#   attr_accessor :name, :age
  
#   def initialize(n, a)
#     self.name = n
#     self.age = a
#   end
  
#   def public_disclosure
#     "#{self.name} in human years is #{human_years}"
#   end
  
#   private
  
#   def human_years
#     age * DOG_YEARS
#   end
# end

# sparky = GoodDog.new("Sparky", 4)
# sparky.public_disclosure

# class Animal
#   def a_public_method
#     "Will this work?" + self.a_protected_method
#   end
  
#   protected
  
#   def a_protected_method
#     "Yes, I'm protected"
#   end
# end

# fido = Animal.new
# puts fido.a_public_method

# Method Overriding

# class Parent
#   def say_hi
#     p "Hi from Parent"
#   end
# end

# class Child < Parent
#   def say_hi
#     p "Hi from Child"
#   end
  
#   def send
#     p "send from Child"
#   end
  
#   def instance_of?
#     p "I'm a fake instance"
#   end
# end 

# child = Child.new
# p child.instance_of? Child
# p child.instance_of? Parent

# Exercises


module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :model, :year
  @@num_of_vehicles = 0
  
  def self.num_of_vehicles
    puts "This class has #{@@num_of_vehicles} vehicles."
  end
  
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    
    @@num_of_vehicles += 1
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
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
  
  def age
    "Your #{self.model} is #{years_old} years old."
  end
  
  private
  
  def years_old
    Time.now.year - self.year
  end
end


class MyCar < Vehicle
  NUM_OF_DOORS = 4
    
  def to_s
    "This car is a #{self.color} #{self.year} #{self.model}."
  end
end

class MyTruck < Vehicle
  include Towable
  
  NUM_OF_DOORS = 2
    
  def to_s
    "This car is a #{self.color} #{self.year} #{self.model}."
  end
end

# lumina = MyCar.new(1996, 'blue', 'chevy lumina')
# lumina.speed_up(20)
# lumina.current_speed
# lumina.speed_up(20)
# lumina.current_speed
# lumina.brake(10)
# lumina.current_speed
# lumina.brake(20)
# lumina.current_speed
# lumina.shut_off
# lumina.current_speed
# MyCar.gas_mileage(13, 351)
# lumina.spray_paint("red")
# puts lumina
# puts MyCar.ancestors
# puts MyTruck.ancestors
# puts Vehicle.ancestors
# puts lumina.age

# class Student
  
#   def initialize(n, g)
#     @name = n
#     @grade = g
#   end
  
#   def better_grade_than?(person)
#     grade > person.grade
#   end
  
#   protected
  
#   def grade
#     @grade
#   end
# end

# joe = Student.new('Joe', 73)
# bob = Student.new('Bob', 91)
# puts "Well done!" if joe.better_grade_than?(bob)

class Thing
end

class AnotherThing < Thing
end

class SomethingElse < AnotherThing
end

puts SomethingElse.ancestors