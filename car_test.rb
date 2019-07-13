require 'minitest/autorun' #  loads all the necessary files from the minitest gem. 
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'car' # We use 'require_relative' to specify the file name from the current file's directory

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end
end

=begin
Within our test class, CarTest, we can write tests by creating an instance 
method that starts with test_. Through this naming convention, Minitest will 
know that these methods are individual tests that need to be run. Within each 
test (or instance method that starts with "test_"), we will need to make some 
assertions. These assertions are what we are trying to verify. Before we make 
ny assertions, however, we have to first set up the appropriate data or objects 
to make assertions against. For example, on line 7, we first instantiate a Car 
object. We then use this car object in our assertion to verify that newly 
created Car objects indeed have 4 wheels.
=end