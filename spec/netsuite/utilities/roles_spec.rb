require 'spec_helper'

describe NetSuite::Rest::Utilities::Roles do

  describe '#get' do
    subject { described_class }
    it { is_expected.to respond_to :get }

    it 'invokes the request module' do
      expect( NetSuite::Rest::Utilities::Request ).to receive(:get)
      subject.get(email: 'jimbob@netzero.com', password: 'pickles')
    end

    it 'formats the API response if successful' do
      allow( NetSuite::Rest::Utilities::Request ).to receive(:get).and_return(
        ["200", {parsed: :response}]
      )
      expect( subject ).to receive(:format_response).with({parsed: :response}).and_return nil
      subject.get(email: 'jimbob@netzero.com', password: 'pickles')
    end

    it 'returns the full error message if unsuccessful' do
      allow( NetSuite::Rest::Utilities::Request ).to receive(:get).and_return(
        ["500", {oh: :no!}]
      )
      expect( subject ).to_not receive(:format_reponse)
      expect( subject.get(email: 'jimbob@netzero.com', password: 'pickles') ).to eq({oh: :no!})
    end
  end

  describe '#format_response' do
    subject { described_class.send(:format_response, parsed) }

    let(:parsed) do
      [
        {
          "account"=>{
            "internalId"=>"TSTDRV15",
            "name"=>"Honeycomb Mfg SDN (Leading)"},
          "role"=>{
            "internalId"=>3,
            "name"=>"Administrator"},
          "dataCenterURLs"=>{
            "webservicesDomain"=>"https://webservices.na1.netsuite.com",
            "restDomain"=>"https://rest.na1.netsuite.com",
            "systemDomain"=>"https://system.na1.netsuite.com"}
        },
        {
          "account"=>{
            "internalId"=>"TSTDRV15",
            "name"=>"Honeycomb Mfg SDN (Leading)"},
          "role"=>{
            "internalId"=>1,
            "name"=>"Accountant"},
           "dataCenterURLs"=>{
             "webservicesDomain"=>"https://webservices.na1.netsuite.com",
             "restDomain"=>"https://rest.na1.netsuite.com",
             "systemDomain"=>"https://system.na1.netsuite.com"}
        },
        {
          "account"=>{
            "internalId"=>"TSTDRV14",
            "name"=>"Honeycomb Mfg SDN (Leading)"},
          "role"=>{
            "internalId"=>1,
            "name"=>"Accountant"},
          "dataCenterURLs"=>{
            "webservicesDomain"=>"https://webservices.netsuite.com",
            "restDomain"=>"https://rest.netsuite.com",
            "systemDomain"=>"https://system.netsuite.com"}
        },
      ]
    end

    it 'groups by uniq account ids' do
      expect( subject.count ).to eq 2
    end

    it 'returns the account name and id' do
      expect( subject.first ).to be_a Hash
      expect( subject.first[:account_id] ).to be_a String
      expect( subject.first[:account_name] ).to be_a String
    end

    it 'returns the account roles' do
      expect( subject.first[:roles] ).to be_an Array
      expect( subject.first[:roles].first ).to be_a Hash
      expect( subject.first[:roles].first[:id] ).to be_an Integer
      expect( subject.first[:roles].first[:name] ).to be_a String
    end

    it 'returns the wsdls' do
      expect( subject.first[:wsdls] ).to be_a Hash
      expect( subject.first[:wsdls][:webservices] ).to be_an Array
      expect( subject.first[:wsdls][:rest] ).to be_an Array
      expect( subject.first[:wsdls][:system] ).to be_an Array
    end

    it 'parses correctly' do
      expect(subject).to eq(
        [
          { account_id: 'TSTDRV15',
            account_name: 'Honeycomb Mfg SDN (Leading)',
            roles: [
              {
                id: 3,
                name: 'Administrator'
              },
              {
                id: 1,
                name: 'Accountant'
              }
            ],
            wsdls: {
              webservices:  ["https://webservices.na1.netsuite.com"],
              rest:         ["https://rest.na1.netsuite.com"],
              system:       ["https://system.na1.netsuite.com"]
            }
          },
          { account_id: 'TSTDRV14',
            account_name: 'Honeycomb Mfg SDN (Leading)',
            roles: [
              {
                id: 1,
                name: 'Accountant'
              }
            ],
            wsdls: {
              webservices:  ["https://webservices.netsuite.com"],
              rest:         ["https://rest.netsuite.com"],
              system:       ["https://system.netsuite.com"]
            }
          }
        ]
      )
    end

    it 'handles an empty response body' do
      expect{
        described_class.send(:format_response, [])
      }.to_not raise_error
    end

  end
end
