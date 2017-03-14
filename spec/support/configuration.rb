RSpec.configure do |config|
  config.before do
    NetSuite.configure do
      reset!
      email    'me@example.com'
      password 'myPassword'
      account  1234
      wsdl     File.expand_path('../2015.wsdl', __FILE__)
    end
  end
end
