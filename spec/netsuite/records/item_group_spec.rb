require 'spec_helper'

describe NetSuite::Records::ItemGroup do
  let(:item) { NetSuite::Records::ItemGroup.new }

  it 'has all the right fields' do
    [
      :available_to_partners, :created_date, :description, :display_name, :include_children, :include_start_end_lines, :is_inactive, :is_vsoe_bundle, :item_id, :last_modified_date, :print_items, :upc_code, :vendor_name
    ].each do |field|
      expect(item).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :custom_form, :default_item_ship_method, :department, :issue_product, :item_ship_method_list, :location
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :item_id => "Item100" }) }

      it 'returns a ItemGroup instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::ItemGroup, {:external_id => 1}], {}).and_return(response)
        item = NetSuite::Records::ItemGroup.get(:external_id => 1)
        expect(item).to be_kind_of(NetSuite::Records::ItemGroup)
        expect(item.item_id).to eql("Item100")
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::ItemGroup, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::ItemGroup.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::ItemGroup with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:item) { NetSuite::Records::ItemGroup.new(:item_id => "Item100", :is_inactive => false) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      item.item_id = "Item100"
      item.is_inactive = false
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:itemId'       => "Item100",
        'listAcct:isInactive' => false
      }
      expect(item.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(item.record_type).to eql('listAcct:ItemGroup')
    end
  end

end
