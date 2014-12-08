require 'spec_helper'

describe NetSuite::Records::BillingScheduleRecurrenceList do
  let(:list) { NetSuite::Records::BillingScheduleRecurrenceList.new }
  let(:recurrence) { NetSuite::Records::BillingScheduleRecurrence.new }

  it 'can have recurrences be added to it' do
    list.recurrences << recurrence
    recurrence_list = list.recurrences
    expect(recurrence_list).to be_kind_of(Array)
    expect(recurrence_list.length).to eql(1)
    recurrence_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::BillingScheduleRecurrence) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:billingScheduleRecurrence' => []
      }
      expect(list.to_record).to eql(record)
    end
  end

end
