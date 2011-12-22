RSpec.configure do |config|
  config.before do
    NetSuite.configure do
      email    'me@example.com'
      password 'myPassword'
      account  1234
    end
  end
end
