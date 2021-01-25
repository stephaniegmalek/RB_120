class GoodDog
  attr_accessor :name

  def initialize
    @name = "sparky"
  end
end

dog = GoodDog.new
p dog.name
dog.name = 'sparta'
p dog.name