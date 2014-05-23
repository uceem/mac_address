# Mac Address

[![Build Status](https://travis-ci.org/uceem/mac_address.svg?branch=master)](https://travis-ci.org/uceem/mac_address)

A Mac Address utility that can validate mac address formats and convert strings to valid macs.

## Installation

Add this line to your application's Gemfile:

```
gem 'mac_address'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install mac_address
```

## Usage

```ruby
MacAddress.new("aa:bb:cc:dd:ee:ff")
# => #<MacAddress:0x007fe783981788 @mac_str="aabbccddeeff">

MacAddress.new("aa:bb:cc:dd:ee:ff").to_s # => 'aabbccddee'
MacAddress.new("invalid mac")            # => Raises ArgumentError
MacAddress.new("aa:bb:cc:dd:ee:ff").to_i # => 187723572702975
```

The MacAddress class will also remove any cruft or extraneous content. If there's a mac to be found, MacAddress will find it:

```ruby
MacAddress.new("aa:bb:cc:dd:ee:ff:qqqqq")
# => #<MacAddress:0x007fe783981788 @mac_str="aabbccddeeff">

MacAddress.new("&*^*&(aa:bb:cc:dd:ee:ff:")
# => #<MacAddress:0x007fe783981788 @mac_str="aabbccddeeff">
```

### String Extending

```ruby
'aa:bb:cc:dd:ee:ff'.to_mac               # => 'aabbccddeeff'
'aa:bb:cc:dd:ee:ff:xx'.to_mac            # => 'aabbccddeeff'
''.to_mac                                # => Raises ArgumentError
'aa:bb:cc:dd:ee:ff'.valid_mac?           # => true
'aa:bb:cc:dd:ee:ff:*&^*qqqq'.valid_mac?  # => true
'aabbcc'.valid_mac?                      # => false
```

Enable strict mode for validation.

```ruby
'aa:bb:cc:dd:ee:ff'.valid_mac?(strict: true)          # => true
'aa:bb:cc:dd:ee:ff:*&^*qqqq'.valid_mac?(strict: true) # => false
```

## Contributing

  1. Fork it
  2. Create your feature branch (git checkout -b my-new-feature)
  3. Commit your changes (git commit -am 'Add some feature')
  4. Push to the branch (git push origin my-new-feature)
  5. Create new Pull Request
