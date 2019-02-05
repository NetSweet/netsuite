$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), '..') ))

require "rubygems"
require "bundler/setup"

Bundler.require

# https://circleci.com/docs/code-coverage
if ENV['CIRCLE_ARTIFACTS']
  require 'simplecov'
  dir = File.join("../../../..", ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
  SimpleCov.start
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir['spec/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.mock_framework = :rspec
  config.color = true
end
