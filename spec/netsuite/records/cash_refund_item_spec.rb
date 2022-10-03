require 'spec_helper'

describe NetSuite::Records::CashRefundItem do
  let(:item) { NetSuite::Records::CashRefundItem.new }

  it 'has all the right fields' do
    [
      :amount, :gross_amt, :rate, :quantity, :is_taxable, :order_line, :line, :description
    ].each do |field|
      expect(item).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :item, :klass
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end

end

