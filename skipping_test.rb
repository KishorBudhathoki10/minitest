require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'car'

class CarTest < MiniTest::Test
  def test_wheels
    car = Car.new
    assert_equal(4, car.wheels)
  end

  def test_bad_wheels
    skip # This method can take message as an argument. for example: skip('this will skip')
    car = Car.new
    assert_equal(3, car.wheels)
  end
end
