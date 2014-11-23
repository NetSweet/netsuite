require 'spec_helper'

describe NetSuite::Actions::Get do
  before(:all) { savon.mock!  }
  after(:all) { savon.unmock! }

  describe 'Customer' do
    context 'retrieving with externalId' do
      before do
        message = {
          'platformMsgs:baseRef' => {
            '@externalId' => 1,
            '@type'       => 'customer',
            '@xsi:type'  => 'platformCore:RecordRef'
          },
        }

        savon.expects(:get).with(:message => message).returns(File.read('spec/support/fixtures/get/get_customer.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::Get.call([NetSuite::Records::Customer, :external_id => 1])
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::Get.call([NetSuite::Records::Customer, :external_id => 1])
        expect(response).to be_kind_of(NetSuite::Response)
      end
    end

    context "retrieving with internalId" do
      before do
        message = {
          'platformMsgs:baseRef' => {
            '@internalId' => 1,
            '@type'       => 'customer',
            '@xsi:type'   => 'platformCore:RecordRef'
          },
        }

        savon.expects(:get).with(:message => message).returns(File.read('spec/support/fixtures/get/get_customer.xml'))
      end

      it "makes a valid request to the NetSuite API" do
        customer = NetSuite::Records::Customer.get(1)
        expect(customer.balance).to eq('100.0')
      end
    end
  end

  describe 'Invoice' do
    before do
      savon.expects(:get).with(:message => {
        'platformMsgs:baseRef' => {
          '@externalId' => 1,
          '@type'       => 'invoice',
          '@xsi:type'  => 'platformCore:RecordRef'
        },
      }).returns(File.read('spec/support/fixtures/get/get_invoice.xml'))
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Get.call([NetSuite::Records::Invoice, :external_id => 1])
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Get.call([NetSuite::Records::Invoice, :external_id => 1])
      expect(response).to be_kind_of(NetSuite::Response)
    end
  end

end
