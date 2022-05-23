require 'spec_helper'

describe NetSuite::Actions::GetSelectValue do
  before(:all) { savon.mock!  }
  after(:all) { savon.unmock! }

  describe 'fulfillment ship method' do
    subject do
      NetSuite::Records::BaseRefList.get_select_value(recordType: 'itemFulfillment', field: 'shipMethod')
    end

    before do
      savon.expects(:get_select_value).with(:message => {
        pageIndex: 1,
        fieldDescription: {
          'platformCore:recordType' => 'itemFulfillment',
          'platformCore:field' => 'shipMethod'
        }
      }).returns(File.read('spec/support/fixtures/get_select_value/item_fulfillment_ship_method.xml'))
    end

    it 'makes a valid request to the NetSuite API' do
      subject
    end

    it 'returns a BaseRefList object' do
      expect(subject).to be_kind_of(NetSuite::Records::BaseRefList)
      expect(subject.base_refs[0].internal_id).to eq('94')
      expect(subject.base_refs[0].name).to eq('Ground (Custom)')
    end
  end
end
