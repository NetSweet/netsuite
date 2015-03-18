require 'spec_helper'

describe NetSuite::Actions::AsyncAddList do
  before { savon.mock! }
  after { savon.unmock! }

  context 'Invoices' do
    context 'one invoice' do
      let(:invoices) do
        [
          NetSuite::Records::Invoice.new(
            entity: NetSuite::Records::Customer.new(internal_id: 1),
            item_list: NetSuite::Records::InvoiceItemList.new(item: {item: NetSuite::Records::RecordRef.new(internal_id: 2), amount: 3}))
        ]
      end

      before do
        savon.expects(:async_add_list).with(:message => {
          "record"=> [{
            :attributes! => {"tranSales:entity" => {"internalId" => 1, "type" => "customer"}},
            "tranSales:entity" => {},
            "tranSales:itemList" => {
              "tranSales:item" => [{
                :attributes! => {"tranSales:item" => {"internalId" => 2}},
                "tranSales:item" => {},
                "tranSales:amount" => 3
              }]
            },
            "@xsi:type" => "tranSales:Invoice"
          }]
        }).returns(File.read('spec/support/fixtures/async_add_list/async_add_list_one_invoice.xml'))
      end

      it 'makes a valid request to the NetSuite API' do
        NetSuite::Actions::AsyncAddList.call([invoices])
      end

      it 'returns a valid Response object' do
        response = NetSuite::Actions::AsyncAddList.call([invoices])
        expect(response).to be_kind_of(NetSuite::Response)
        expect(response).to be_success
      end
    end
  end

  context 'two invoices' do
    let(:invoices) do
      [
        NetSuite::Records::Invoice.new(
          entity: NetSuite::Records::Customer.new(internal_id: 1),
          item_list: NetSuite::Records::InvoiceItemList.new(item: {item: NetSuite::Records::RecordRef.new(internal_id: 2), amount: 3})),
        NetSuite::Records::Invoice.new(
            entity: NetSuite::Records::Customer.new(internal_id: 2),
            item_list: NetSuite::Records::InvoiceItemList.new(item: {item: NetSuite::Records::RecordRef.new(internal_id: 3), amount: 4})),
      ]
    end

    before do
      savon.expects(:async_add_list).with(:message => {
        "record"=> [{
          :attributes! => {"tranSales:entity" => {"internalId" => 1, "type" => "customer"}},
          "tranSales:entity" => {},
          "tranSales:itemList" => {
            "tranSales:item" => [{
              :attributes! => {"tranSales:item" => {"internalId" => 2}},
              "tranSales:item" => {},
              "tranSales:amount" => 3
           }]
          },
          "@xsi:type" => "tranSales:Invoice"
        }, {
          :attributes! => {"tranSales:entity" => {"internalId" => 2, "type" => "customer"}},
          "tranSales:entity" => {},
          "tranSales:itemList" => {
            "tranSales:item" => [{
             :attributes! => {"tranSales:item" => {"internalId" => 3}},
             "tranSales:item" => {},
             "tranSales:amount" => 4
           }]
          },
          "@xsi:type" => "tranSales:Invoice"
        }]
      }).returns(File.read('spec/support/fixtures/async_add_list/async_add_list_one_invoice.xml'))
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::AsyncAddList.call([invoices])
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::AsyncAddList.call([invoices])
      expect(response).to be_kind_of(NetSuite::Response)
      expect(response).to be_success
    end
  end
end
