require 'minitest/autorun'

require_relative 'car_for_more_assertions'

class CarTest < MiniTest::Test
  def setup  # The setup method will be called before running every test.
    @car = Car.new
  end

  def test_car_exists
    assert(car)
  end

  def test_wheels
    assert_equal(4, car.wheels)
  end

  def test_name_is_nil
    assert_nil(car.name)
  end

  def test_raise_initialize_with_arg
    assert_raises(ArgumentError) do
      Car.new(name: 'Joey')  # This code raises ArgumentError, so this assertion passes 
    end
  end

  def test_instance_of_car
    assert_instance_of(Car, car)
  end

  def test_includes_car
    arr = [1, 2, 3]
    arr << car

    assert_includes(arr, car)
    # assert_includes calls 'assert_equal' in its implementation, and Minitest counts that call
    # as a separate assertion. For each assert_includes call, you will get 2 assertions, not 1.
  end

  private

  attr_reader :car
end
