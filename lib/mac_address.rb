require 'str_quote'
require 'mac_address/version'

class MacAddress
  def initialize(str)
    @mac_str = str.strip.dequote.strip
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

  def self.validate(mac)
    MacAddress.new(mac).to_s
    true
  rescue ArgumentError
    false
  end
end

class String
  def to_mac
    MacAddress.new(self).to_s
  end

  def valid_mac?(options = {})
    if options[:strict]
      MacAddress.validate_strict(self)
    else
      MacAddress.validate(self)
    end
  end
end
