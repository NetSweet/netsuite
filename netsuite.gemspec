# -*- encoding: utf-8 -*-
require File.expand_path('../lib/netsuite/version', __FILE__)

Gem::Specification.new do |gem|
  gem.licenses      = ['MIT']
  gem.authors       = ['Ryan Moran', 'Michael Bianco', 'Chris Gunther']
  gem.email         = ['ryan.moran@gmail.com', 'mike@mikebian.co', 'chris@room118solutions.com']
  gem.description   = %q{NetSuite SuiteTalk API Wrapper}
  gem.summary       = %q{NetSuite SuiteTalk API (SOAP) Wrapper}
  gem.homepage      = 'https://github.com/NetSweet/netsuite'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'netsuite'
  gem.require_paths = ['lib']
  gem.version       = NetSuite::VERSION
  gem.required_ruby_version = '>= 2.1'
  gem.metadata['changelog_uri'] = 'https://github.com/netsweet/netsuite/blob/master/HISTORY.md'
  gem.metadata['mailing_list_uri'] = 'http://opensuite-slackin.herokuapp.com'
  gem.metadata['rubygems_mfa_required'] = 'true'

  gem.add_dependency 'savon', '>= 2.3.0', '!= 2.13.0'

  gem.add_development_dependency 'rspec', '~> 3.12.0'
  gem.add_development_dependency 'rake', '~> 12.3.3'
end
