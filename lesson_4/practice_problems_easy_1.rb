# Question 1
true.class
# TrueClass

"hello".class
# String 

[1, 2, 3, "happy days"].class
# Array

142.class
# Integer

# Question 2
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

Car.new.go_fast
Truck.new.go_fast

# Question 3
=begin
We use 'self.class` in the method:
- `self` refers to the object that is referenced by the local variable 'small_car' which is a Car object. 
- We then call the '#class' method on the Car object which is how we get 'Car'
- we don't need to use `to_s` here because it is interpolated 
=end

# Question 4
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

cat = AngryCat.new
cat.hiss

# Question 5
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Pizza class has an instance variable. Know b/c name is prefixed with @. 
# could also use `#instance_variables` method

hot_pizza = Pizza.new("cheese")
orange = Fruit.new("apple")
hot_pizza.instance_variables
orange.instance_variables

# Question 6
class Cube
  def initialize(volume)
    @volume = volume
  end
  
  def get_volume
    @volume
  end
end

# can technically access instance variable directrly from the object by calling 
# instance_variable_get

big_cube = Cube.new(5000)
big_cube.instance_variable_get("@volume")

big_cube.get_volume

# Question 7
=begin
What is the default return value of `to_s` when invoked on an object? 

It returns the object's class and an encoding of the object id.
=end

# Question 8
class Cat
  attr_accessor :type, :age
  
  def initialize(type)
    @type = type
    @age = 0
  end
  
  def make_one_year_older
    self.age += 1
  end
end

# `self` refers to the object/instance. Also note the method is an instance method
# so it can only be called on instances of the class.

# Question 9 
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

# `self` refers to the class `Cat`. It is a class method

Cat.cats_count

# Question 10 
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

bag = Bag.new("brown", "paper")