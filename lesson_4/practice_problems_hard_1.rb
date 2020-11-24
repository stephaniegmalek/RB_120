# Question 1
class SecretFile
  
  def initialize(secret_data, logger)
    @data = secret_data
    @logger = logger
  end
  
  def data
    @logger.create_log_entry
    @data
  end
end

class SecurityLogger
  def create_log_entry
    # method logic
  end
end

# Question 2
module Movable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency
  
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Movable
  
  def initialize(tire_array, km_traveled_per_liter, litters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = litters_of_fuel_capacity
  end
  
  def tire_pressure(tire_index)
    @tires[tire_index]
  end
  
  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    super([30, 30, 32, 32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    super([20, 20], 80, 8.0)
  end
end

class Seacraft
  include Movable

  attr_reader :propeller_count, :hull_count
  
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, litters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = litters_of_fuel_capacity
  end
  
  def range
    super + 10
  end
end

class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, litters_of_fuel_capacity)
    super
  end
end

class Motorboat < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, litters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, litters_of_fuel_capacity)
  end
end