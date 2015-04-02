require 'spec_helper'

describe NetSuite::Records::CustomerPaymentCreditList do
  let(:list) { NetSuite::Records::CustomerPaymentCreditList.new }
  let(:credit) { NetSuite::Records::CustomerPaymentCredit.new }

  it 'has a credits attribute' do
    expect(list.credits).to be_kind_of(Array)
  end

  it 'can have credits be added to it' do
    list.credits << credit
    credit_list = list.credits
    expect(credit_list).to be_kind_of(Array)
    expect(credit_list.length).to eql(1)
    credit_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::CustomerPaymentCredit) }
  end

  it 'can be initialized with an array of credit hashes' do
    list = NetSuite::Records::CustomerPaymentCreditList.new(credit: [{}])
    credit_list = list.credits
    expect(credit_list).to be_kind_of(Array)
    expect(credit_list.length).to eql(1)
    credit_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::CustomerPaymentCredit) }
  end

  it 'can be initialized with a single credit hash' do
    list = NetSuite::Records::CustomerPaymentCreditList.new(credit: {})
    credit_list = list.credits
    expect(credit_list).to be_kind_of(Array)
    expect(credit_list.length).to eql(1)
    credit_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::CustomerPaymentCredit) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
          'tranCust:credit' => []
      }
      expect(list.to_record).to eql(record)
    end
  end
end
