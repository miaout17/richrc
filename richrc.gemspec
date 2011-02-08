# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "richrc/version"

Gem::Specification.new do |s|
  s.name        = "richrc"
  s.version     = Richrc::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["miaout17"]
  s.email       = ["miaout17 at gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Load Wirble and Hirb in Rails 3 without editing Gemfile}
  s.description = %q{Load Wirble and Hirb in Rails 3 without editing Gemfile}

  s.rubyforge_project = "richrc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
