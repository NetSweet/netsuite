# -*- encoding: utf-8 -*-
require File.expand_path('../lib/netsuite/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Ryan Moran']
  gem.email         = ['ryan.moran@gmail.com']
  gem.description   = %q{NetSuite SuiteTalk API Wrapper}
  gem.summary       = %q{NetSuite SuiteTalk API Wrapper}
  gem.homepage      = 'https://github.com/RevolutionPrep/netsuite'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'netsuite'
  gem.require_paths = ['lib']
  gem.version       = Netsuite::VERSION

  gem.add_dependency 'savon', '0.9.7'
  gem.add_dependency 'nokogiri'

  gem.add_development_dependency 'rspec',               '2.8.0'
  gem.add_development_dependency 'autotest-standalone', '4.5.9'
  gem.add_development_dependency 'savon_spec',          '0.1.6'
end
