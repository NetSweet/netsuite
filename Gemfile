source 'https://rubygems.org'
gemspec

gem 'simplecov', :require => false

gem 'pry-nav'
gem 'pry-rescue'


if ENV.fetch('BUNDLE_TZINFO', 'false') == 'true'
  # optional dependency for more accurate timezone conversion
  gem 'tzinfo', '>= 1.2.5'
end

if RUBY_VERSION >= '3.1.0'
  # Savon v2.13 adds a dependency on mail, which has an implicit dependency on
  # net-smtp. Ruby 3.1 removed net-smtp as a default gem. mail v2.8.0.rc1 is the
  # first to make that dependency explicit to support Ruby 3.1.
  gem 'mail', '>= 2.8.0.rc1'
end
