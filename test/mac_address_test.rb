require 'test/unit'
require 'mac_address'

class MacAddressTest < Test::Unit::TestCase
  def test_truth
    assert_kind_of Module, MacAddress
  end
  
  def test_mac
    assert_equal 'aabbccddeeff', 'AA-BB-CC-DD-EE-FF:hello world'.to_mac
  end
end
