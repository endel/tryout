$:.push File.expand_path('../lib', __FILE__)
require 'tryout/version'

Gem::Specification.new do |s|
  s.name        = "tryout"
  s.version     = Tryout::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Endel Dreyer"]
  s.email       = ["endel.dreyer@gmail.com"]
  s.homepage    = "http://github.com/endel/tryout"

  s.summary     = "Clean begin/rescue/retry utility."
  s.description = "Allows you to do dirty stuff without messing up your code base."
  s.licenses    = ['MIT']

  s.add_development_dependency "activesupport", ">= 3.0.0"
  s.add_development_dependency "rspec", ">= 2.0.0"
  s.add_development_dependency "yard", "~> 0.8.3"
  s.add_development_dependency "redcarpet", "~> 2.2.2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]
end

