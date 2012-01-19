require 'spec_helper'

describe NetSuite::Records::JournalEntry do
  let(:entry) { NetSuite::Records::JournalEntry.new }

# <element name="lineList" type="tranGeneral:JournalEntryLineList" minOccurs="0"/>
  it 'has all the right fields' do
    [
     :approved, :created_date, :exchange_rate, :last_modified_date, :reversal_date,
     :reversal_defer, :reversal_entry, :tran_date, :tran_id
    ].each do |field|
      entry.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :created_from, :currency, :custom_form, :department, :klass, :location, :parent_expense_alloc, :posting_period,
      :subsidiary, :to_subsidiary
    ].each do |record_ref|
      entry.should have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10
        }
      }
      entry.custom_field_list = attributes
      entry.custom_field_list.should be_kind_of(NetSuite::Records::CustomFieldList)
      entry.custom_field_list.custom_fields.length.should eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      entry.custom_field_list = custom_field_list
      entry.custom_field_list.should eql(custom_field_list)
    end
  end

end
