require 'spec_helper'

describe NetSuite::Records::CustomRecordType do
  let(:record_type) { NetSuite::Records::CustomRecordType.new }

# <element name="owner" type="platformCore:RecordRef" minOccurs="0"/>

# <element name="fieldList" type="setupCustom:CustomRecordTypeFieldList" minOccurs="0"/>
# <element name="tabsList" type="setupCustom:CustomRecordTypeTabsList" minOccurs="0"/>
# <element name="sublistsList" type="setupCustom:CustomRecordTypeSublistsList" minOccurs="0"/>
# <element name="formsList" type="setupCustom:CustomRecordTypeFormsList" minOccurs="0"/>
# <element name="onlineFormsList" type="setupCustom:CustomRecordTypeOnlineFormsList" minOccurs="0"/>
# <element name="permissionsList" type="setupCustom:CustomRecordTypePermissionsList" minOccurs="0"/>
# <element name="linksList" type="setupCustom:CustomRecordTypeLinksList" minOccurs="0"/>
# <element name="managersList" type="setupCustom:CustomRecordTypeManagersList" minOccurs="0"/>
# <element name="childrenList" type="setupCustom:CustomRecordTypeChildrenList" minOccurs="0"/>
# <element name="parentsList" type="setupCustom:CustomRecordTypeParentsList" minOccurs="0"/>
# <element name="translationsList" type="setupCustom:CustomRecordTypeTranslationsList" minOccurs="0"/>
  it 'has all the right fields' do
    [
      :allow_attachments, :allow_inline_editing, :allow_numbering_override, :allow_quick_search, :description, :disclaimer,
      :enable_mail_merge, :enable_numbering, :include_name, :is_available_offline, :is_inactive, :is_numbering_updateable,
      :is_ordered, :numbering_current_number, :numbering_init, :numbering_min_digits, :numbering_prefix, :numbering_suffix,
      :record_name, :script_id, :show_creation_date, :show_creation_date_on_list, :show_id, :show_last_modified,
      :show_last_modified_on_list, :show_notes, :show_owner, :show_owner_allow_change, :show_owner_on_list, :use_permissions
    ].each do |field|
      record_type.should have_field(field)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :allow_attachments => true }) }

      it 'returns a Customer instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).
          with(NetSuite::Records::CustomRecordType, :external_id => 1).
          and_return(response)
        record_type = NetSuite::Records::CustomRecordType.get(:external_id => 1)
        record_type.should be_kind_of(NetSuite::Records::CustomRecordType)
        record_type.allow_attachments.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).
          with(NetSuite::Records::CustomRecordType, :external_id => 1).
          and_return(response)
        lambda {
          NetSuite::Records::CustomRecordType.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::CustomRecordType with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
