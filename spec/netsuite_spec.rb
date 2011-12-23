require 'spec_helper'

describe NetSuite do
  let(:config) { NetSuite::Configuration }

  before do
    config.reset!
  end

  describe '#configure' do
    it 'allows the Configuration #email instance method to be called with instance eval' do
      NetSuite.configure do
        email 'me@example.com'
      end
      config.email.should eql('me@example.com')
    end

    it 'allows the Configuration #password instance method to be called with instance eval' do
      NetSuite.configure do
        password 'myPassword'
      end
      config.password.should eql('myPassword')
    end

    it 'allows the Configuration #account instance method to be called with instance eval' do
      NetSuite.configure do
        account 1234
      end
      config.account.should eql(1234)
    end

    it 'allows the Configuration #wsdl instance method to be called with instance_eval' do
      NetSuite.configure do
        wsdl 'https://system.sandbox.netsuite.com/wsdl/v2011_2_0/netsuite.wsdl'
      end
      config.wsdl.should eql('https://system.sandbox.netsuite.com/wsdl/v2011_2_0/netsuite.wsdl')
    end

  end

end
