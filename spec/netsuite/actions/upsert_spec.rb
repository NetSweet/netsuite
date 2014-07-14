require 'spec_helper'

describe NetSuite::Actions::Upsert do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  context 'Customer' do
    let(:customer) do
      NetSuite::Records::Customer.new(:entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.')
    end

    before do
      savon.expects(:upsert).with(:message => {
        'platformMsgs:record' => {
          :content! => {
            'listRel:entityId'    => 'Shutter Fly',
            'listRel:companyName' => 'Shutter Fly, Inc.'
          },
          '@xsi:type' => 'listRel:Customer'
        },
      }).returns(File.read('spec/support/fixtures/upsert/upsert_customer.xml'))
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Upsert.call([customer])
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Upsert.call([customer])
      expect(response).to be_kind_of(NetSuite::Response)
      expect(response).to be_success
    end
  end

  context 'Invoice' do
    let(:invoice) do
      NetSuite::Records::Invoice.new(:source => 'Google', :total => 100.0)
    end

    context 'when successful' do
      before do
        savon.expects(:upsert).with(:message => {
          'platformMsgs:record' => {
            :content! => {
              'tranSales:source' => 'Google'
            },
            '@xsi:type' => 'tranSales:Invoice'
          },
        }).returns(File.read('spec/support/fixtures/upsert/upsert_invoice.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::Upsert.call([invoice])
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::Upsert.call([invoice])
        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
      end
    end

    context 'when not successful' do
      before do
        savon.expects(:upsert).with(:message => {
          'platformMsgs:record' => {
            :content! => {
              'tranSales:source' => 'Google'
            },
            '@xsi:type' => 'tranSales:Invoice'
          },
        }).returns(File.read('spec/support/fixtures/upsert/upsert_invoice_error.xml'))
      end

      it 'provides an error method on the object with details about the error' do
        invoice.upsert
        error = invoice.errors.first

        expect(error).to be_kind_of(NetSuite::Error)
        expect(error.type).to eq('ERROR')
        expect(error.code).to eq('INVALID_KEY_OR_REF')
        expect(error.message).to eq('The specified key is invalid.')
      end

      it 'provides an error method on the response' do
        response = NetSuite::Actions::Upsert.call([invoice])
        expect(response.errors.first).to be_kind_of(NetSuite::Error)
      end
    end

    context 'when not successful with multiple errors' do
      before do
        savon.expects(:upsert).with(:message => {
          'platformMsgs:record' => {
            :content! => {
              'tranSales:source' => 'Google'
            },
            '@xsi:type' => 'tranSales:Invoice'
          },
        }).returns(File.read('spec/support/fixtures/upsert/upsert_invoice_multiple_errors.xml'))
      end

      it 'provides an error method on the object with details about the error' do
        invoice.upsert
        expect(invoice.errors.length).to eq(2)

        error = invoice.errors.first

        expect(error).to be_kind_of(NetSuite::Error)
        expect(error.type).to eq('ERROR')
        expect(error.code).to eq('ERROR')
        expect(error.message).to eq('Some message')
      end
    end
  end

end
