class Person
  #attr_accessor :name
  attr_reader :name
  attr_writer :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name