require 'spec_helper'

describe NetSuite::Records::CustomerRefundApplyList do
  let(:list) { NetSuite::Records::CustomerRefundApplyList.new }

  it 'has a applies attribute' do
    expect(list.applies).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.applies << NetSuite::Records::CustomerRefundApply.new(:amount => 10)
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'tranCust:apply' => [{
          'tranCust:amount' => 10
        }]
      }
      list.to_record.should eql(record)
    end
  end

end
