require 'spec_helper'

describe NetSuite::Records::InterCompanyJournalEntryLine do
  let(:line) { NetSuite::Records::InterCompanyJournalEntryLine.new }

  it 'has all the right fields' do
    [
      :amortization_end_date, :amortization_residual, :amortiz_start_date, :credit, :debit, :eliminate, :end_date, :gross_amt, :memo,
      :residual, :start_date, :tax1_amt, :tax_rate1
    ].each do |field|
      expect(line).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :department, :entity, :klass, :line_subsidiary, :location, :schedule, :schedule_num, :tax1_acct, :tax_code
    ].each do |record_ref|
      expect(line).to have_record_ref(record_ref)
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
      expect(line.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(line.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      line.custom_field_list = custom_field_list
      expect(line.custom_field_list).to eql(custom_field_list)
    end
  end

  describe '#to_record' do
    let(:line) { NetSuite::Records::InterCompanyJournalEntryLine.new(:memo => 'This is a memo', :eliminate => true) }

    it 'returns a hash of attributes that can be used in a SOAP request' do
      expect(line.to_record).to eql({
        'tranGeneral:memo'      => 'This is a memo',
        'tranGeneral:eliminate' => true
      })
    end
  end

  describe '#record_type' do
    it 'returns a string type for the record to be used in a SOAP request' do
      expect(line.record_type).to eql('tranGeneral:InterCompanyJournalEntryLine')
    end
  end

end
