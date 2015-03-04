require 'spec_helper'

describe NetSuite::Records::VendorPaymentApplyList do
  let(:list) { NetSuite::Records::VendorPaymentApplyList.new }
  let(:apply) { NetSuite::Records::VendorPaymentApply.new }

  it 'can have applies be added to it' do
    list.applies << apply
    apply_list = list.applies
    expect(apply_list).to be_kind_of(Array)
    expect(apply_list.length).to eql(1)
    apply_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::VendorPaymentApply) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
          'tranPurch:apply' => [{},{}]
      }
      list.applies.concat([apply,apply])
      expect(list.to_record).to eql(record)
    end
  end

end
