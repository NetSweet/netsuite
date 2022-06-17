require 'spec_helper'

describe NetSuite::Actions::Add do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  context 'Customer' do
    let(:customer) do
      NetSuite::Records::Customer.new(:entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.')
    end

    before do
      savon.expects(:add).with(:message => {
        'platformMsgs:record' => {
          :content! => {
            'listRel:entityId'    => 'Shutter Fly',
            'listRel:companyName' => 'Shutter Fly, Inc.'
          },
          '@xsi:type' => 'listRel:Customer'
        },
      }).returns(File.read('spec/support/fixtures/add/add_customer.xml'))
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Add.call([customer])
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Add.call([customer])
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
        savon.expects(:add).with(:message => {
          'platformMsgs:record' => {
            :content! => {
              'tranSales:source' => 'Google'
            },
            '@xsi:type' => 'tranSales:Invoice'
          },
        }).returns(File.read('spec/support/fixtures/add/add_invoice.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::Add.call([invoice])
      end

      it 'returns a valid Response object with no errors' do
        response = NetSuite::Actions::Add.call([invoice])
        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
        expect(response.errors).to be_empty
      end
    end

    context 'when not successful' do
      before do
        savon.expects(:add).with(:message => {
          'platformMsgs:record' => {
            :content! => {
              'tranSales:source' => 'Google'
            },
            '@xsi:type' => 'tranSales:Invoice'
          },
        }).returns(File.read('spec/support/fixtures/add/add_invoice_error.xml'))
      end

      it 'provides an error method on the object with details about the error' do
        invoice.add
        error = invoice.errors.first

        expect(error).to be_kind_of(NetSuite::Error)
        expect(error.type).to eq('ERROR')
        expect(error.code).to eq('INVALID_INITIALIZE_REF')
        expect(error.message).to eq('You can not initialize invoice: invalid reference 7281.')
      end

      it 'provides an error method on the response' do
        response = NetSuite::Actions::Add.call([invoice])
        expect(response.errors.first).to be_kind_of(NetSuite::Error)
      end
    end

    context 'when not successful with multiple errors' do
      before do
        savon.expects(:add).with(:message => {
          'platformMsgs:record' => {
            :content! => {
              'tranSales:source' => 'Google'
            },
            '@xsi:type' => 'tranSales:Invoice'
          },
        }).returns(File.read('spec/support/fixtures/add/add_invoice_multiple_errors.xml'))
      end

      it 'provides an error method on the object with details about the error' do
        invoice.add
        expect(invoice.errors.length).to eq(2)

        error = invoice.errors.first

        expect(error).to be_kind_of(NetSuite::Error)
        expect(error.type).to eq('ERROR')
        expect(error.code).to eq('ERROR')
        expect(error.message).to eq('Some message')
      end
    end
  end

  context 'File' do
    let(:file) do
      NetSuite::Records::File.new(name: 'foo.pdf', content: 'abc123')
    end

    context 'when successful' do
      before do
        savon.expects(:add).with(:message => {
          'platformMsgs:record' => {
            :content! => {
              'fileCabinet:name' => 'foo.pdf',
              'fileCabinet:content' => 'abc123',
            },
            '@xsi:type' => 'fileCabinet:File'
          },
        }).returns(File.read('spec/support/fixtures/add/add_file.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::Add.call([file])
      end

      it 'returns a valid Response object with no errors' do
        response = NetSuite::Actions::Add.call([file])
        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
        expect(response.errors).to be_empty
      end

      it 'properly extracts internal ID from response' do
        file.add

        expect(file.internal_id).to eq('23556')
      end
    end
  end

end
