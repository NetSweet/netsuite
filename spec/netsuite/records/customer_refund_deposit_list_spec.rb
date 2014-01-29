require 'spec_helper'

describe NetSuite::Records::CustomerRefundDepositList do
  let(:list) { NetSuite::Records::CustomerRefundDepositList.new }

  it 'has a deposits attribute' do
    list.deposits.should be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.deposits << NetSuite::Records::CustomerRefundDeposit.new(:apply => false)
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'tranCust:customerRefundDeposit' => [{
          'tranCust:apply' => false
        }]
      }
      list.to_record.should eql(record)
    end
  end

end
