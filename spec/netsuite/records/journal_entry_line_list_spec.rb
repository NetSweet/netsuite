require 'spec_helper'

describe NetSuite::Records::JournalEntryLineList do
  let(:list) { NetSuite::Records::JournalEntryLineList.new }

  it 'has a custom_fields attribute' do
    list.lines.should be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      pending
      list.lines << NetSuite::Records::JournalEntryLine.new
    end

    it 'can represent itself as a SOAP record' do
      record = [
        {
          'tranGeneral:JournalEntryLine' => {
            'platformCore:value' => false
          },
          :attributes! => {
            'tranGeneral:JournalEntryLine' => {
              'internalId' => '3',
              'xsi:type'   => 'BooleanCustomFieldRef'
            }
          }
        }
      ]
      list.to_record.should eql(record)
    end
  end

end
