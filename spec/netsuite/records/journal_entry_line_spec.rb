require 'spec_helper'

describe NetSuite::Records::JournalEntryLine do
  let(:line) { NetSuite::Records::JournalEntryLine.new }

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
          :amount => 10,
          :internal_id => 'custfield_amount'
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

  describe '#to_record' do
    let(:line) { NetSuite::Records::JournalEntryLine.new(:memo => 'This is a memo', :eliminate => true) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      line.to_record.should eql({
        'tranGeneral:memo'      => 'This is a memo',
        'tranGeneral:eliminate' => true
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      line.record_type.should eql('tranGeneral:JournalEntryLine')
    end
  end

end
