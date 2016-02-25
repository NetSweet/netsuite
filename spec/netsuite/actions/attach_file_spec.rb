require 'spec_helper'

describe NetSuite::Actions::AttachFile do
  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  let(:invoice) { NetSuite::Records::Invoice.new(internal_id: 999) }
  let(:file) {  double('file', internal_id: 111) }
  let(:message) do
    {
      'platformCore:attachReference' => {
        '@xsi:type' => 'platformCore:AttachBasicReference',
        'platformCore:attachTo' => {
          '@internalId' => invoice.internal_id,
          '@type' => invoice.type,
          '@xsi:type' => 'platformCore:RecordRef'
        },
        'platformCore:attachedRecord' => {
          '@internalId' => file.internal_id,
          '@type' => 'file',
          '@xsi:type' => 'platformCore:RecordRef'
        }
      }
    }
  end

  before do
    savon.expects(:attach).with(:message => message).returns(envelope)
  end

  context 'when successful' do
    let(:envelope) { File.read('spec/support/fixtures/attach/attach_file_to_invoice.xml') }

    it 'returns a valid Response object' do
      response = NetSuite::Actions::AttachFile.call([invoice, file])
      expect(response).to be_kind_of(NetSuite::Response)
      expect(response).to be_success
    end
  end

  context 'when not successful' do
    let(:envelope) { File.read('spec/support/fixtures/attach/attach_file_to_invoice_error.xml') }

    it 'provides an error method on the object with details about the error' do
      invoice.attach_file(file)
      error = invoice.errors.first

      expect(error).to be_kind_of(NetSuite::Error)
      expect(error.type).to eq('ERROR')
      expect(error.code).to eq('INVALID')
      expect(error.message).to eq('Invalid request.')
    end

    it 'provides an error method on the response' do
      response = NetSuite::Actions::AttachFile.call([invoice, file])
      expect(response.errors.first).to be_kind_of(NetSuite::Error)
    end
  end
end
