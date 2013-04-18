$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..') ))

require 'rspec'
require 'rspec/autorun'
require 'netsuite'
# require 'savon_spec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir['spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.mock_framework = :rspec
  config.color_enabled = true
end
