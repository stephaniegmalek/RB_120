class Flight
 # attr_accessor :database_handle # remove from code so doesn't cause potential problems in future
  
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# issue is we're providing easy access to the '@database_handle' instance variable
# when it is just an implementation detail. B/c it's an implementation detail, users
# of class should have no use for it and so we shouldn't provide direct access to it