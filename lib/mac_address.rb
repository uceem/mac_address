require 'str_quote'
require 'mac_address/version'

class MacAddress
  def initialize(str, options = {})
    @mac_str = str.strip.dequote.strip

    if options[:strict] && !MacAddress.validate_strict(@mac_str)
      raise_argument_error(@mac_str)
    end

    n = @mac_str.index(':')
    if not n.nil? and n >= 12
      @mac_str = @mac_str.split(':')[0]
    end
    @mac_str = @mac_str.downcase.gsub(/^0[xX]/,'').gsub(/[^0-9a-f]/,'')

    raise ArgumentError.new("Invalid MAC address: #{str}") if @mac_str.length != 12
  end

  def to_s
    @mac_str
  end

  def to_i
    @mac_str.hex
  end

  def self.validate_strict(mac)
    !!(mac =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i)
  end

  def self.validate(mac, options = {})
    if options[:strict]
      MacAddress.validate_strict(mac)
    else
      MacAddress.new(mac).to_s
      true
    end
  rescue ArgumentError
    false
  end

private

  def raise_argument_error(mac_str, error_str = nil)
    raise ArgumentError.new(error_str || "Invalid MAC address: #{mac_str}")
  end
end

class String
  def to_mac(options = {})
    MacAddress.new(self, options).to_s
  end

  def valid_mac?(options = {})
    MacAddress.validate(self, options)
  end
end
