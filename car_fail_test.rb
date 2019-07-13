require 'minitest/reporters'
Minitest::Reporters.use!
require 'minitest/autorun'

require_relative 'car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_bad_wheels
    car = Car.new
    assert_equal(3, car.wheels)
  end
end

=begin
When we run the code in the output: The last line gives us a quick summary, and 
we can see that there are now 2 assertions and 1 failure. Minitest further 
gives us the exact failing test, and also tells us the expected value vs the 
actual value. Also notice at the top, there's a "F.", which means there were 2 
tests, one of which failed (that's the "F") and one of which passed (that's the 
".").
=end