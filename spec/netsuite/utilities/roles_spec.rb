require 'spec_helper'

describe NetSuite::Rest::Utilities::Roles do
  subject { described_class }

  describe '#get' do
    it { is_expected.to respond_to :get }

    it 'invokes the request module' do
      expect( NetSuite::Rest::Utilities::Request ).to receive(:get)
      subject.get('jimbob@netzero.com', 'pickles')
    end

    it 'formats the API response if successful' do
      allow( NetSuite::Rest::Utilities::Request ).to receive(:get).and_return(
        ["200", {parsed: :response}]
      )
      expect( subject ).to receive(:format_response).with({parsed: :response}).and_return nil
      subject.get('jimbob@netzero.com', 'pickles')
    end

    it 'returns the full error message if unsuccessful' do
      allow( NetSuite::Rest::Utilities::Request ).to receive(:get).and_return(
        ["500", {oh: :no!}]
      )
      expect( subject ).to_not receive(:format_reponse)
      expect( subject.get('jimbob@netzero.com', 'pickles') ).to eq({oh: :no!})
    end
  end

  describe '#format_response' do
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
                "webservicesDomain"=>"https://webservices.na1.netsuite.com",
                "restDomain"=>"https://rest.na1.netsuite.com",
                "systemDomain"=>"https://system.na1.netsuite.com"}
        },
      ]
    end

    it 'pulls out the account_ids' do
      expect(
        subject.send(:format_response, parsed).fetch(:accounts)
      ).to eq ["TSTDRV15","TSTDRV14"]
    end

    it 'pulls out the role_ids' do
      expect(
        subject.send(:format_response, parsed).fetch(:roles)
      ).to eq [3, 1]
    end

    it 'pulls out the wsdls' do
      expect(
        subject.send(:format_response, parsed).fetch(:wsdls)
      ).to eq ["https://webservices.na1.netsuite.com"]
    end

    it 'handles an empty response body' do
      expect{
        subject.send(:format_response, [])
      }.to_not raise_error
    end

  end
end
