require 'spec_helper'

describe NetSuite::Records::JournalEntryLineList do
  let(:list) { NetSuite::Records::JournalEntryLineList.new }

  it 'has a custom_fields attribute' do
    list.lines.should be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.lines << NetSuite::Records::JournalEntryLine.new(:memo => 'This is a memo')
    end

    it 'can represent itself as a SOAP record' do
      record = 
        {
          'tranGeneral:line' => [{
            'tranGeneral:memo' => 'This is a memo'
          }]
        }
      list.to_record.should eql(record)
    end
  end

end
