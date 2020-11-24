# Question 1
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
  
  # Question 2 answer
  def self.hi
    greeting = Greeting.new
    greeting.greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new
# hello.hi
# 'hello'

# hello.bye
# NoMethodError

# hello.greet
# Method Error b/c no argument

# hello.greet("Goodbye")
# 'Goodbye'

# Hello.hi
# No Method Error - instance method not class method

# Question 2
# see above

# Question 3
class AngryCat
  def initialize(age, name)
    @age = age
    @name = name
  end
  
  def age
    puts @age
  end
  
  def name
    @name
  end
  
  def hiss
    puts "Hisssss!!!"
  end
end

kat1 = AngryCat.new(2, "Spot")
kat2 = AngryCat.new(5, "Paws")

# Question 4
class Cat
  attr_reader :type

  def initialize(type)
    @tupe = type
  end
  
  def to_s
    "I am a #{type} cat"
  end
end

# Question 5
class Television
  def self.manufacturer
    # method logic
  end
  
  def model
    # method logic
  end
end

tv = Television.new
# tv.manufacturer
# error - manufacturer is a class method and can only be called on class Television
tv.model
Television.manufacturer
# Television.model
# error - model is an instance method and can only be called on instances of Television

# Question 6
class Cat
  attr_reader :type, :age
  
  def initialize(type)
    @type = type
    @age = 0
  end
  
  def make_one_year_older
    self.age += 1
    # @age += 1
  end
end

# Question 7
class Light
  attr_accessor :brightness, :color
  
  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end
  
  def self.information
    "I want to turn on the light with a brightness level of #{brightness} and a color of #{color}"
  end
end