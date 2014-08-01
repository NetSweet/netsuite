require 'spec_helper'

describe NetSuite::Records::BillingScheduleRecurrence do
  let(:recurrence) { NetSuite::Records::BillingScheduleRecurrence.new }

  it 'has the right fields' do
    [
      :amount, :count, :recurrence_date, :recurrence_id,
      :relative_to_previous, :units
    ].each do |field|
      recurrence.should have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :payment_terms
    ].each do |record_ref|
      recurrence.should have_record_ref(record_ref)
    end
  end

  it 'can initialize from a record' do
    record = NetSuite::Records::BillingScheduleRecurrence.new(:amount => 10)
    recurrence = NetSuite::Records::BillingScheduleRecurrence.new(record)
    recurrence.should be_kind_of(NetSuite::Records::BillingScheduleRecurrence)
    recurrence.amount.should eql(10)
  end

  describe '#to_record' do
    before do
      recurrence.amount = 10
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:amount' => 10
      }
      recurrence.to_record.should eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP record type' do
      recurrence.record_type.should eql('listAcct:BillingScheduleRecurrence')
    end
  end

end
