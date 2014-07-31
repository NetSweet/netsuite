require 'spec_helper'

describe NetSuite::Records::DiscountItem do
  let(:item) { NetSuite::Records::DiscountItem.new }

  it 'has the right fields' do
    [
      :available_to_partners, :created_date, :description, :display_name, :include_children, :is_inactive, :is_pretax,
      :item_id, :last_modified_date, :non_posting, :rate, :upc_code, :vendor_name
    ].each do |field|
      item.should have_field(field)
    end

    # TODO there is a probably a more robust way to test this
    item.custom_field_list.class.should == NetSuite::Records::CustomFieldList
  end

  it 'has the right record_refs' do
    [
      :account, :custom_form, :deferred_revenue_account, :department, :expense_account,
      :income_account, :issue_product, :klass, :location, :parent, :rev_rec_schedule, :sales_tax_code,
      :subsidiary_list, :tax_schedule
    ].each do |record_ref|
      item.should have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :item_id => 'penguins' }) }

      it 'returns a DiscountItem instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::DiscountItem, :external_id => 20], {}).and_return(response)
        customer = NetSuite::Records::DiscountItem.get(:external_id => 20)
        customer.should be_kind_of(NetSuite::Records::DiscountItem)
        customer.item_id.should eql('penguins')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with([NetSuite::Records::DiscountItem, :external_id => 20], {}).and_return(response)
        lambda {
          NetSuite::Records::DiscountItem.get(:external_id => 20)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::DiscountItem with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    # let(:item) { NetSuite::Records::DiscountItem.new(:cost => 100, :is_inactive => false) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Add.should_receive(:call).
            with([item], {}).
            and_return(response)
        item.add.should be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Add.should_receive(:call).
            with([item], {}).
            and_return(response)
        item.add.should be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Delete.should_receive(:call).
            with([item], {}).
            and_return(response)
        item.delete.should be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Delete.should_receive(:call).
            with([item], {}).
            and_return(response)
        item.delete.should be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      item.item_id = 'penguins'
      item.is_inactive = true
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:itemId' => 'penguins',
        'listAcct:isInactive'     => true
      }
      item.to_record.should eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP type' do
      item.record_type.should eql('listAcct:DiscountItem')
    end
  end

end
