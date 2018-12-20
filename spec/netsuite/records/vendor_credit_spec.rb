require 'spec_helper'

describe NetSuite::Records::VendorCredit do
  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :@internal_id => '1', :@external_id =>'some_id' }) }

      it 'returns a VendorCredit instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::VendorCredit, external_id: 'some_id'], {}).and_return(response)
        vendor_credit = NetSuite::Records::VendorCredit.get(external_id: 'some_id')
        expect(vendor_credit).to be_kind_of(NetSuite::Records::VendorCredit)
        expect(vendor_credit.internal_id).to eq('1')
        expect(vendor_credit.external_id).to eq('some_id')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::VendorCredit, external_id: 'some_id'], {}).and_return(response)
        expect {
          NetSuite::Records::VendorCredit.get(external_id: 'some_id')
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::VendorCredit with OPTIONS=(.*) could not be found/)
      end
    end
  end
end
