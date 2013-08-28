$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mac_address/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mac_address"
  s.version     = MacAddress::VERSION
  s.authors     = ["Doug Wiegley"]
  s.email       = ["doug@uceem.com"]
  s.homepage    = "https://github.com/uceem/mac_address"
  s.summary     = "Mac address manipulation"
  s.description = "Parse, validate, convert mac addresses, and String methods"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md", "LICENSE"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "str_quote"
end
