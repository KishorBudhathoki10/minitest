require 'minitest/autorun'

class EqualityTest < Minitest::Test
  def test_value_equality
    str1 = 'hi there'
    str2 = 'hi there'

    assert_equal(str1, str2)
    assert_same(str1, str2) # object id and valur should be same of both comparing objects or else it wont pass.
  end
end
