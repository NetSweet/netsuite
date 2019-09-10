# -*- encoding: utf-8 -*-
require File.expand_path('../lib/netsuite/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Ryan Moran', 'Michael Bianco']
  gem.email         = ['ryan.moran@gmail.com', 'mike@cliffsidemedia.com']
  gem.description   = %q{NetSuite SuiteTalk API Wrapper}
  gem.summary       = %q{NetSuite SuiteTalk API (SOAP) Wrapper}
  gem.homepage      = 'https://github.com/NetSweet/netsuite'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'netsuite'
  gem.require_paths = ['lib']
  gem.version       = NetSuite::VERSION

  gem.add_dependency 'savon', '>= 2.3.0'

  gem.add_development_dependency 'rspec', '~> 3.8.0'
end
