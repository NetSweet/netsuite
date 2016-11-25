require 'spec_helper'

describe NetSuite::Records::CreditMemoApplyList do
  let(:list) { NetSuite::Records::CreditMemoApplyList.new }
  let(:apply) { NetSuite::Records::CreditMemoApply.new }

  it 'has all the right fields' do
    [
        :amount, :apply, :apply_date, :currency, :doc, :due, :job, :line, :ref_num, :total, :type
    ].each do |field|
      expect(apply).to have_field(field)
    end
  end

  it 'can have applies be added to it' do
    list.applies << apply
    apply_list = list.applies
    expect(apply_list).to be_kind_of(Array)
    expect(apply_list.length).to eql(1)
    apply_list.each { |i| expect(i).to be_kind_of(NetSuite::Records::CreditMemoApply) }
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
          'tranCust:apply' => [{},{}]
      }
      list.applies.concat([apply, apply])
      expect(list.to_record).to eql(record)
    end
  end
end
