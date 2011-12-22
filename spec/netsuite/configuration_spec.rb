require 'spec_helper'

describe NetSuite::Configuration do
  let(:config) { NetSuite::Configuration }

  before do
    config.reset!
  end

  describe '#reset!' do
    it 'clears the attributes hash' do
      config.attributes[:blah] = 'something'
      config.attributes.should_not be_empty
      config.reset!
      config.attributes.should be_empty
    end
  end

  describe '#connection' do
    it 'returns a Savon::Client object that allows requests to the service' do
      config.connection.should be_kind_of(Savon::Client)
    end
  end

  describe '#wsdl' do
    it 'returns a path to the WSDL to use for the API' do
      config.wsdl.should match(/.*\/netsuite\/wsdl\/2011_02\.wsdl/)
    end
  end

  describe '#auth_header' do
    before do
      config.email    = 'user@example.com'
      config.password = 'myPassword'
      config.account  = 1234
    end

    it 'returns a hash representation of the authentication header' do
      config.auth_header.should eql({
        'platformMsgs:passport' => {
          'platformCore:email'    => 'user@example.com',
          'platformCore:password' => 'myPassword',
          'platformCore:account'  => '1234'
        }
      })
    end
  end

  describe '#email' do
    context 'when the email has been set' do
      before do
        config.email = 'test@example.com'
      end

      it 'returns the email' do
        config.email.should eql('test@example.com')
      end
    end

    context 'when the email has not been set' do
      it 'raises a ConfigurationError' do
        lambda {
          config.email
        }.should raise_error(NetSuite::ConfigurationError,
          '#email is a required configuration value. Please set it by calling NetSuite::Configuration.email = "me@example.com"')
      end
    end
  end

  describe '#password' do
    context 'when the password has been set' do
      before do
        config.password = 'password'
      end

      it 'returns the password' do
        config.password.should eql('password')
      end
    end

    context 'when the password has not been set' do
      it 'raises a ConfigurationError' do
        lambda {
          config.password
        }.should raise_error(NetSuite::ConfigurationError,
          '#password is a required configuration value. Please set it by calling NetSuite::Configuration.password = "my_pass"')
      end
    end
  end

  describe '#account' do
    context 'when the account has been set' do
      before do
        config.account = 4321
      end

      it 'returns the account' do
        config.account.should eql(4321)
      end
    end

    context 'when the account has not been set' do
      it 'raises a ConfigurationError' do
        lambda {
          config.account
        }.should raise_error(NetSuite::ConfigurationError,
          '#account is a required configuration value. Please set it by calling NetSuite::Configuration.account = 1234')
      end
    end
  end

end
