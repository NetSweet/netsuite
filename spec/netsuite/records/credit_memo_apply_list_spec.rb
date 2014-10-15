require 'spec_helper'

describe NetSuite::Records::CreditMemoApplyList do
  let(:list) { NetSuite::Records::CreditMemoApplyList.new }

  it 'has a applies attribute' do
    expect(list.applies).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.applies << NetSuite::Records::CreditMemoApply.new(
        :job => 'something'
      )
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'tranCust:apply' => [{
          'tranCust:job' => 'something'
        }]
      }

      expect(list.to_record.should).tq eq(record)
    end
  end
end
