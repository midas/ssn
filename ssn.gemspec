# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ssn/version"

Gem::Specification.new do |s|
  s.name        = "ssn"
  s.version     = Ssn::VERSION
  s.authors     = ["C. Jason Harrelson (midas)"]
  s.email       = ["jason@lookforwardenterprises.com"]
  s.homepage    = "https://github.com/midas/ssn"
  s.summary     = %q{Easily use SSNs in your app.}
  s.description = %q{Encapsulates functionality for storing an unformatted SSN but formatting the SSN on print.}

  s.rubyforge_project = "ssn"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rails", "3.1.0"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "guard"
  s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'growl'
	s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'ruby-debug'

  s.add_runtime_dependency "rails"
end
