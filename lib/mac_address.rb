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
end

class String
  def to_mac
    MacAddress.new(self).to_s
  end
  
  def valid_mac?
    begin
      MacAddress.new(self).to_s
    rescue ArgumentError => e
      return false
    end
    
    true
  end
end