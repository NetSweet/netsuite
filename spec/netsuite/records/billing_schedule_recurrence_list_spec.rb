require 'spec_helper'

describe NetSuite::Records::BillingScheduleRecurrenceList do
  let(:list) { NetSuite::Records::BillingScheduleRecurrenceList.new }
  let(:recurrence) { NetSuite::Records::BillingScheduleRecurrence.new }

  it 'can have recurrences be added to it' do
    list.recurrences << recurrence
    recurrence_list = list.recurrences
    recurrence_list.should be_kind_of(Array)
    recurrence_list.length.should eql(1)
    recurrence_list.each { |i| i.should be_kind_of(NetSuite::Records::BillingScheduleRecurrence) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:billingScheduleRecurrence' => []
      }
      list.to_record.should eql(record)
    end
  end

end
