require 'spec_helper'

describe NetSuite::Configuration do
  let(:config) { NetSuite::Configuration }

  before do
    config.reset!
  end

  describe '#reset!' do
    it 'clears the attributes hash' do
      config.attributes[:blah] = 'something'
      expect(config.attributes).not_to be_empty
      config.reset!
      expect(config.attributes).to be_empty
    end
  end

  describe '#connection' do
    it 'returns a Savon::Client object that allows requests to the service' do
      # reset clears out the password info
      config.email 'me@example.com'
      config.password 'me@example.com'
      config.account 1023

      expect(config.connection).to be_kind_of(Savon::Client)
    end
  end

  describe '#wsdl' do
    context 'when the wsdl has been set' do
      before do
        config.wsdl = 'https://system.sandbox.netsuite.com/wsdl/v2011_2_0/netsuite.wsdl'
      end

      it 'returns a path to the WSDL to use for the API' do
        expect(config.wsdl).to eql('https://system.sandbox.netsuite.com/wsdl/v2011_2_0/netsuite.wsdl')
      end
    end

    context 'when the wsdl has not been set' do
      it 'returns a path to the WSDL to use for the API' do
        expect(config.wsdl).to match(/.*\/netsuite\/wsdl\/2011_2\.wsdl/)
      end
    end

    context 'when the wsdl has not been set, but the API has been set' do
      it 'should correctly return the full HTTP sandbox URL' do
        config.api_version '2013_1'
        config.sandbox false
        expect(config.wsdl).to eql('https://webservices.netsuite.com/wsdl/v2013_1_0/netsuite.wsdl')
      end
    end

    context 'when the API and wsdl domain have been set' do
      it 'should correctly modify the full wsdl path' do
        config.sandbox = false
        config.api_version '2014_1'
        config.wsdl_domain = 'system.na1.netsuite.com'

        expect(config.wsdl).to eql('https://system.na1.netsuite.com/wsdl/v2014_1_0/netsuite.wsdl')
      end
    end
  end

  describe '#auth_header' do
    before do
      config.email    = 'user@example.com'
      config.password = 'myPassword'
      config.account  = 1234
    end

    it 'returns a hash representation of the authentication header' do
      expect(config.auth_header).to eql({
        'platformMsgs:passport' => {
          'platformCore:email'    => 'user@example.com',
          'platformCore:password' => 'myPassword',
          'platformCore:account'  => '1234',
          'platformCore:role'     => { :@internalId => '3' },
        }
      })
    end
  end

  describe '#soap_header' do
    before do
      config.email    = 'user@example.com'
      config.password = 'myPassword'
      config.account  = 1234
    end

    it 'adds a new header to the soap header' do
      config.soap_header = {
        'platformMsgs:preferences' => {
          'platformMsgs:ignoreReadOnlyFields' => true,
        }
      }
      expect(config.soap_header).to eql({
        'platformMsgs:preferences' => {
          'platformMsgs:ignoreReadOnlyFields' => true,
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
        expect(config.email).to eql('test@example.com')
      end
    end

    context 'when the email has not been set' do
      it 'raises a ConfigurationError' do
        expect(config.email).to be_nil
      end
    end
  end

  describe '#password' do
    context 'when the password has been set' do
      before do
        config.password = 'password'
      end

      it 'returns the password' do
        expect(config.password).to eql('password')
      end
    end

    context 'when the password has not been set' do
      it 'raises a ConfigurationError' do
        expect(config.password).to be_nil
      end
    end
  end

  describe '#account' do
    context 'when the account has been set' do
      before do
        config.account = 4321
      end

      it 'returns the account' do
        expect(config.account).to eql(4321)
      end
    end

    context 'when the account has not been set' do
      it 'raises a ConfigurationError' do
        expect(config.account).to be_nil
      end
    end
  end


  describe '#role' do
    context 'when no role is defined' do
      it 'defaults to "3"' do
        expect(config.role).to eq("3")
      end
    end
  end

  describe '#role=' do
    it 'sets the role according to the input value' do
      config.role = "6"
      expect(config.role).to eq("6")
    end
  end

  describe '#api_version' do
    context 'when no api_version is defined' do
      it 'defaults to 2011_2' do
        expect(config.api_version).to eq('2011_2')
      end
    end
  end

  describe '#api_version=' do
    context 'when api version is defined' do
      it 'sets the api_version of the application' do
        config.api_version = '2012_1'
        expect(config.api_version).to eq('2012_1')
      end
    end
  end

  describe "#credentials" do
    context "when none are defined" do
      skip "should properly create the auth credentials" do

      end
    end

    context "when they are defined" do
      it "should properly replace the default auth credentials" do

      end
    end
  end

end
