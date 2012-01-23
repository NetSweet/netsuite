require 'spec_helper'

describe NetSuite::Records::CustomerRefundDeposit do
  let(:deposit) { NetSuite::Records::CustomerRefundDeposit.new }

  it 'has all the right fields' do
    [
      :amount, :apply, :currency, :deposit_date, :doc, :line, :ref_num, :remaining, :total
    ].each do |field|
      deposit.should have_field(field)
    end
  end

end
