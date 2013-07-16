RSpec.configure do |config|
  config.before do
    NetSuite.configure do
      reset!
      email    'me@example.com'
      password 'myPassword'
      account  1234
      role     5
    end
  end
end
