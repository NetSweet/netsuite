require 'spec_helper'

describe NetSuite::Records::JournalEntryLine do
  let(:line) { NetSuite::Records::JournalEntryLine.new }

# <element name="customFieldList" type="platformCore:CustomFieldList" minOccurs="0"/>
  it 'has all the right fields' do
    [
      :credit, :debit, :eliminate, :end_date, :gross_amt, :memo, :residual, :start_date, :tax1_amt, :tax_rate1
    ].each do |field|
      line.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :department, :entity, :klass, :location, :schedule, :schedule_num, :tax1_acct, :tax_code
    ].each do |record_ref|
      line.should have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10
        }
      }
      line.custom_field_list = attributes
      line.custom_field_list.should be_kind_of(NetSuite::Records::CustomFieldList)
      line.custom_field_list.custom_fields.length.should eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      line.custom_field_list = custom_field_list
      line.custom_field_list.should eql(custom_field_list)
    end
  end

end
