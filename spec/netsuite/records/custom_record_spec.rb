require 'spec_helper'

describe NetSuite::Records::CustomRecord do
  let(:record) { NetSuite::Records::CustomRecord.new }
#<element name="customForm" type="platformCore:RecordRef" minOccurs="0"/>
#<element name="owner" type="platformCore:RecordRef" minOccurs="0"/>
#<element name="recType" type="platformCore:RecordRef" minOccurs="0"/>
#<element name="customFieldList" type="platformCore:CustomFieldList" minOccurs="0"/>

  it 'has all the right fields' do
    [
      :allow_attachments, :allow_inline_editing, :allow_numbering_override, :allow_quick_search, :created, :custom_record_id,
      :description, :disclaimer, :enabl_email_merge, :enable_numbering, :include_name, :is_available_offline, :is_inactive,
      :is_numbering_updateable, :is_ordered, :last_modified, :name, :numbering_current_number, :numbering_init,
      :numbering_min_digits, :numbering_prefix, :numbering_suffix, :record_name, :script_id, :show_creation_date,
      :show_creation_date_on_list, :show_id, :show_last_modified, :show_last_modified_on_list, :show_notes, :show_owner,
      :show_owner_allow_change, :show_owner_on_list, :use_permissions
    ].each do |field|
      record.should have_field(field)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :allow_quick_search => true }) }

      it 'returns a Customer instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).
          with(NetSuite::Records::CustomRecord, :external_id => 1, :type_id => nil, :custom => true).
          and_return(response)
        customer = NetSuite::Records::CustomRecord.get(1)
        customer.should be_kind_of(NetSuite::Records::CustomRecord)
        customer.allow_quick_search.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).
          with(NetSuite::Records::CustomRecord, :external_id => 1, :type_id => nil, :custom => true).
          and_return(response)
        lambda {
          NetSuite::Records::CustomRecord.get(1)
        }.should raise_error(NetSuite::RecordNotFound, 'NetSuite::Records::CustomRecord with ID=1 could not be found')
      end
    end
  end

end
