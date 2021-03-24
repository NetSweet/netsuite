require 'spec_helper'

describe NetSuite::Records::CustomerPaymentCreditList do
  let(:list) { NetSuite::Records::CustomerPaymentCreditList.new }
  let(:apply) { NetSuite::Records::CustomerPaymentCredit.new }

  it 'can have credits be added to it' do
    list.credits << apply
    credit_list = list.credits
    expect(credit_list).to be_kind_of(Array)
    expect(credit_list.length).to eql(1)
    credit_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::CustomerPaymentCredit) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
          'tranCust:credit' => [{},{}]
      }

      list.credits.concat([apply, apply])
      expect(list.to_record).to eql(record)
    end
  end

end
