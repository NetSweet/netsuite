require 'spec_helper'

describe NetSuite::Records::CustomRecordType do
  let(:record_type) { NetSuite::Records::CustomRecordType.new }

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

  it 'has all the right record refs' do
    [
      :owner
    ].each do |record_ref|
      record_type.should have_record_ref(record_ref)
    end
  end

  describe '#field_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypeFieldList object'
  end

  describe '#tabs_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypeTabsList object'
  end

  describe '#sublists_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypeSublistsList object'
  end

  describe '#forms_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypeFormsList object'
  end

  describe '#online_forms_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypeOnlineFormsList object'
  end

  describe '#permissions_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypePermissionsList object'
  end

  describe '#links_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypeLinksList object'
  end

  describe '#managers_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypeManagersList object'
  end

  describe '#children_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypeChildrenList object'
  end

  describe '#parents_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypeParentsList object'
  end

  describe '#translations_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomRecordTypeTranslationsList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :allow_attachments => true }) }

      it 'returns a Customer instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).
          with([NetSuite::Records::CustomRecordType, :external_id => 1], {}).
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
          with([NetSuite::Records::CustomRecordType, :external_id => 1], {}).
          and_return(response)
        lambda {
          NetSuite::Records::CustomRecordType.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::CustomRecordType with OPTIONS=(.*) could not be found/)
      end
    end
  end

    describe '#add' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Add.should_receive(:call).
            with([record_type], {}).
            and_return(response)
        record_type.add.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Add.should_receive(:call).
            with([record_type], {}).
            and_return(response)
        record_type.add.should be_false
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        NetSuite::Actions::Delete.should_receive(:call).
            with([record_type], {}).
            and_return(response)
        record_type.delete.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        NetSuite::Actions::Delete.should_receive(:call).
            with([record_type], {}).
            and_return(response)
        record_type.delete.should be_false
      end
    end
  end

end
