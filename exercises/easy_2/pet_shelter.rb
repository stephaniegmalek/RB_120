class Pet
  attr_reader :type, :name
  
  def initialize(type, name)
    @type = type
    @name = name
  end
  
  def to_s
    "a #{type} named #{name}"
  end
end

class Owner
  attr_reader :name, :pets
  
  def initialize(name)
    @name = name
    @pets = []
  end
  
  def add_pet(pet)
    @pets << pet
  end
  
  def number_of_pets
    @pets.size
  end
  
  def print_pets
    puts pets
  end
end

class Shelter
  def initialize
    @adoptions = {}
    @animals_to_adopt = []
  end
  
  def add_animal_to_shelter(pet)
    @animals_to_adopt << pet
  end
  
  def adopt(owner, pet)
    owner.add_pet(pet)
    @adoptions[owner.name] ||= owner
  end
  
  def print_adoptions
    @adoptions.each do |owner_name, pets|
      puts "#{owner_name} has adopted the following pets:"
      puts pets.pets
      puts ''
    end
  end
  
  def print_available_pets
    puts "The Animal Shelter has the following unadopted pets:"
    @animals_to_adopt.each do |animal|
      puts animal
    end
    puts ''
  end
  
  def available_pets
    @animals_to_adopt.size
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.add_animal_to_shelter(asta)
shelter.add_animal_to_shelter(laddie)
shelter.add_animal_to_shelter(fluffy)
shelter.add_animal_to_shelter(kat)
shelter.add_animal_to_shelter(ben)
shelter.add_animal_to_shelter(chatterbox)
shelter.add_animal_to_shelter(bluebell)

shelter.print_adoptions

shelter.print_available_pets

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal Shelter has #{shelter.available_pets} unadopted pets."