require 'spec_helper'

describe NetSuite::Records::DiscountItem do
  let(:item) { NetSuite::Records::DiscountItem.new }

  it 'has the right fields' do
    [
      :available_to_partners, :created_date, :description, :display_name, :include_children, :is_inactive, :is_pre_tax,
      :item_id, :last_modified_date, :non_posting, :rate, :upc_code, :vendor_name
    ].each do |field|
      expect(item).to have_field(field)
    end

    # TODO there is a probably a more robust way to test this
    expect(item.custom_field_list.class).to eq(NetSuite::Records::CustomFieldList)
  end

  it 'has the right record_refs' do
    [
      :account, :custom_form, :deferred_revenue_account, :department, :expense_account,
      :income_account, :issue_product, :klass, :location, :parent, :rev_rec_schedule, :sales_tax_code,
      :subsidiary_list, :tax_schedule
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :item_id => 'penguins' }) }

      it 'returns a DiscountItem instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::DiscountItem, :external_id => 20], {}).and_return(response)
        customer = NetSuite::Records::DiscountItem.get(:external_id => 20)
        expect(customer).to be_kind_of(NetSuite::Records::DiscountItem)
        expect(customer.item_id).to eql('penguins')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::DiscountItem, :external_id => 20], {}).and_return(response)
        expect {
          NetSuite::Records::DiscountItem.get(:external_id => 20)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::DiscountItem with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    # let(:item) { NetSuite::Records::DiscountItem.new(:cost => 100, :is_inactive => false) }

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
      item.item_id = 'penguins'
      item.is_inactive = true
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:itemId' => 'penguins',
        'listAcct:isInactive'     => true
      }
      expect(item.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP type' do
      expect(item.record_type).to eql('listAcct:DiscountItem')
    end
  end

end
