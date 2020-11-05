class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name

# What output does this code print? Fix this class so that there are no surprises 
# waiting in store for the unsuspecting developer.

# to_s method was overridden by the instance method and is uppercasing the user
# input during the initialize process.  It is also mutating the instance 
# variable @name by calling @name.upcase! unnecessarily.

#further exploration 


name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# the local variable name is not the same as the getter method 'name' being 
# called on fluffy.  '@name' is being initialized to "42".  42.upcase is still
# "42" which is output on line 33.  puts name on line 36 references the local
# variable 'name' that is initialized on line 30 and incremented on line 32.