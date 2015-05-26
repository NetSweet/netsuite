require 'spec_helper'

describe NetSuite::Records::CustomerRefundApplyList do
  let(:list) { NetSuite::Records::CustomerRefundApplyList.new }
  let(:apply) { NetSuite::Records::CustomerRefundApply.new }

  it 'can have applies be added to it' do
    list.applies << apply
    apply_list = list.applies
    expect(apply_list).to be_kind_of(Array)
    expect(apply_list.length).to eql(1)
    apply_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::CustomerRefundApply) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'tranCust:apply' => [{
          'tranCust:amount' => 10
        }]
      }
      expect(list.to_record).to eql(record)
    end
  end

end
