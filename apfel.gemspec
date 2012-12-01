# encoding: utf-8
lib_folder = File.join(File.dirname(__FILE__), 'lib')
apfel_folder = File.join(File.dirname(__FILE__), 'lib', 'apfel')
$:.unshift apfel_folder
require "version"

Gem::Specification.new do |s|
  s.name        = "apfel"
  s.version     = Apfel::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Levick"]
  s.email       = ["ryan.levick@gmail.com"]
  s.homepage    = "https://github.com/rlevick/apfel"
  s.summary     = %q{Simple parser for DotStrings Files}
  s.description = %q{Parse valid .strings files for easy conversion to other formats}

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
  s.add_development_dependency "pry"

  s.rubyforge_project = "apfel"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
