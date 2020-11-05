# Question 1
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end
  
  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
oracle.predict_the_future
# You will + one of the strings from array in choices 

# Question 2
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end
  
  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

trip = RoadTrip.new
trip.predict_the_future
# "You will <something>" The something will be one of the 3 option in the choices mehtod in Road Trip
# b/c we call `predict_the_future` on an instance of RoadTrip, it starts with methods definied on the
# class you are calling 

# Question 3
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste 
end

# what is the lookup chain for Orange and HotSauce
# Orange Taste Object Kernal BasicObject
# Hotsauce Taste Object Kernal BasicObject

# can use `ancestors` method on class 

# Question 4
class BeesWax
  attr_accessor :type
  
  def initialize(type)
    @type = type 
  end
  
  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

# Question 5 
excited_dog = "excited dog"
# local variable - no prefix

@excited_dog = "excited dog"
# instance variable - prefixed with 1 @

@@excited_dog = "excited dog"
# class variable = prefixed with 2 @

# Question 6
class Television
  def self.manufacturer
    # method logic
  end
  
  def model
    # method logic
  end
end

# `self.manufacturer` is a class method
# can tell b/c starts with `self` 
# to call, call on class not object/instance of class
Television.manufacturer

# Question 7
class Cat
  @@cats_count = 0
  
  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end
  
  def self.cats_count
    @@cats_count
  end
end

=begin
The `@@cats_count` variable stores how many instances of Cat objects there are
each time a new cat object is instantiated, `@@cats_count` increments by 1. To
see how many cat objects there are you can call `cats_count` method on the cat class
=end

# p Cat.cats_count
# kitty = Cat.new('black')
# p Cat.cats_count

# paws = Cat.new('orange')
# ginger = Cat.new('orange')
# p Cat.cats_count

# Question 8
class Game 
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    # rules of play
  end
end

puts Bingo.new.play

# Question 9
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
  
  end
end

=begin
if we added a method named `play` in `Bingo` class then thats the method that would be executed 
=end

# Question 10
=begin
Many benefits for using OOP, just a few: 
Creating objects allows programmers to think more abstractly about the code they are writing.

Objects are represented by nouns so are easier to conceptualize.

It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much harder to come across.

It allows us to easily give functionality to different parts of an application without duplication.

We can build applications faster as we can reuse pre-written code.

As the software becomes more complex this complexity can be more easily managed.

=end