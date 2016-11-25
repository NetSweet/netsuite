require 'spec_helper'

describe NetSuite::Records::CashSaleItem do
  let(:item) { NetSuite::Records::CashSaleItem.new }

  it 'has all the right fields' do
    [
      :amount
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

