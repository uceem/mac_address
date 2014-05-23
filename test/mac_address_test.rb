require 'test/unit'
require 'mac_address'

class MacAddressTest < Test::Unit::TestCase

  VALID_MACS          = %w[aa:bb:cc:dd:ee:ff 00:11:22:33:44:55]
  INVALID_MACS        = %w[invalid aabbccddeeffff aa:bb:cc:dd:ee:ff:11]
  INVALID_MACS_STRICT = %w[aabbccddeeff aabbccddeeffxx aa:bb:cc:dd:ee:ff:xx 00:55:56:82:11::38 0011.2233.445566]

  def test_truth
    assert_kind_of Module, MacAddress
  end

  def test_mac
    assert_equal 'aabbccddeeff', 'AA-BB-CC-DD-EE-FF:hello world'.to_mac
  end

  def test_mac_strict
    assert_equal 'aabbccddeeff', 'aa:bb:cc:dd:ee:ff'.to_mac(strict: true)
  end

  def test_error_raise_with_invalid_mac
    assert_raise ArgumentError do
      MacAddress.new(INVALID_MACS.first.to_mac)
    end
  end

  def test_error_raise_with_invalid_mac_strict
    assert_raise ArgumentError do
      MacAddress.new(INVALID_MACS_STRICT.first.to_mac(strict: true))
    end
  end

  def test_error_raise_with_invalid_mac_for_string
    assert_raise ArgumentError do
      INVALID_MACS.first.to_mac
    end
  end

  def test_error_raise_with_invalid_mac_strict_for_string
    assert_raise ArgumentError do
      INVALID_MACS_STRICT.first.to_mac(strict: true)
    end
  end

  def test_valid_mac
    VALID_MACS.each do |valid_mac|
      assert_equal valid_mac.valid_mac?, true
      assert_equal valid_mac.valid_mac?(strict: true), true
    end
  end

  def test_invalid_macs
    INVALID_MACS.each do |invalid_mac|
      assert_equal invalid_mac.valid_mac?, false
      assert_equal invalid_mac.valid_mac?(strict: true), false
    end
  end

  def test_invalid_macs_strict
    INVALID_MACS_STRICT.each do |invalid_mac|
      assert_equal invalid_mac.valid_mac?(strict: true), false
    end
  end
end
