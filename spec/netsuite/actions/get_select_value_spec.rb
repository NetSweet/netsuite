require 'spec_helper'

describe NetSuite::Actions::GetSelectValue do
  before(:all) { savon.mock!  }
  after(:all) { savon.unmock! }

  describe 'fulfillment ship method' do
    subject do
      NetSuite::Records::BaseRefList.get_select_value(recordType: 'itemFulfillment', field: 'shipMethod')
    end

    let(:response) { File.read('spec/support/fixtures/get_select_value/item_fulfillment_ship_method.xml') }

    before do
      savon.expects(:get_select_value).with(:message => {
        pageIndex: 1,
        fieldDescription: {
          'platformCore:recordType' => 'itemFulfillment',
          'platformCore:field' => 'shipMethod'
        }
      }).returns(response)
    end

    it 'makes a valid request to the NetSuite API' do
      subject
    end

    it 'returns a BaseRefList object' do
      expect(subject).to be_kind_of(NetSuite::Records::BaseRefList)
      expect(subject.base_refs[0].internal_id).to eq('94')
      expect(subject.base_refs[0].name).to eq('Ground (Custom)')
    end

    context 'with empty result' do
      let(:response) { File.read('spec/support/fixtures/get_select_value/empty_result.xml') }

      it 'returns an empty list' do
        # NoMethodError:
        #   private method `select' called for nil:NilClass
        # # ./lib/netsuite/support/attributes.rb:14:in `initialize_from_attributes_hash'
        # # ./lib/netsuite/support/sublist.rb:34:in `initialize'
        # # ./lib/netsuite/actions/get_select_value.rb:52:in `new'
        # # ./lib/netsuite/actions/get_select_value.rb:52:in `get_select_value'
        # # ./spec/netsuite/actions/get_select_value_spec.rb:9:in `block (3 levels) in <top (required)>'
        # # ./spec/netsuite/actions/get_select_value_spec.rb:38:in `block (4 levels) in <top (required)>'
        expect(subject).to be_kind_of(NetSuite::Records::BaseRefList)
        expect(subject.base_refs).to be_empty
      end
    end
  end
end
