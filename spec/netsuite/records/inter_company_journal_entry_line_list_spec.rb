require 'spec_helper'

describe NetSuite::Records::InterCompanyJournalEntryLineList do
  let(:list) { NetSuite::Records::InterCompanyJournalEntryLineList.new }

  it 'has a custom_fields attribute' do
    expect(list.lines).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.lines << NetSuite::Records::InterCompanyJournalEntryLine.new(:memo => 'This is a memo')
    end

    it 'can represent itself as a SOAP record' do
      record =
        {
          'tranGeneral:line' => [{
            'tranGeneral:memo' => 'This is a memo'
          }]
        }
      expect(list.to_record).to eql(record)
    end
  end

end
