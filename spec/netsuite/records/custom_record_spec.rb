require 'spec_helper'

describe NetSuite::Records::CustomRecord do
  let(:record) { NetSuite::Records::CustomRecord.new }

  it 'has all the right fields' do
    [
      :allow_attachments, :allow_inline_editing, :allow_numbering_override, :allow_quick_search, :created, :custom_record_id,
      :description, :disclaimer, :enabl_email_merge, :enable_numbering, :include_name, :is_available_offline, :is_inactive,
      :is_numbering_updateable, :is_ordered, :last_modified, :name, :numbering_current_number, :numbering_init,
      :numbering_min_digits, :numbering_prefix, :numbering_suffix, :record_name, :script_id, :show_creation_date,
      :show_creation_date_on_list, :show_id, :show_last_modified, :show_last_modified_on_list, :show_notes, :show_owner,
      :show_owner_allow_change, :show_owner_on_list, :use_permissions
    ].each do |field|
      expect(record).to have_field(field)
    end
  end

  it 'has all the right record_refs' do
    [
      :custom_form, :owner, :rec_type, :parent
    ].each do |record_ref|
      expect(record).to have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10,
          :script_id => 'custfield_amount'
        }
      }
      record.custom_field_list = attributes
      expect(record.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(record.custom_field_list.custom_fields.length).to eql(1)
      expect(record.custom_field_list.custfield_amount.attributes[:amount]).to eq(10)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      record.custom_field_list = custom_field_list
      expect(record.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :allow_quick_search => true }) }

      it 'returns a Customer instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).
          with([NetSuite::Records::CustomRecord, {:external_id => 1, :type_id => nil, :custom => true}], {}).
          and_return(response)
        customer = NetSuite::Records::CustomRecord.get(:external_id => 1)
        expect(customer).to be_kind_of(NetSuite::Records::CustomRecord)
        expect(customer.allow_quick_search).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).
          with([NetSuite::Records::CustomRecord, {:external_id => 1, :type_id => nil, :custom => true}], {}).
          and_return(response)
        expect {
          NetSuite::Records::CustomRecord.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::CustomRecord with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([record], {}).
            and_return(response)
        expect(record.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([record], {}).
            and_return(response)
        expect(record.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([record, { :custom => true }], {}).
            and_return(response)
        expect(record.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([record, { :custom => true }], {}).
            and_return(response)
        expect(record.delete).to be_falsey
      end
    end
  end

end
