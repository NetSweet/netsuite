require 'spec_helper'

describe NetSuite::Records::CustomerRefundApply do
  let(:apply) { NetSuite::Records::CustomerRefundApply.new }

  it 'has all the right fields' do
    [
      :amount, :apply, :apply_date, :currency, :doc, :due, :line, :ref_num, :total, :type
    ].each do |field|
      apply.should have_field(field)
    end
  end

end
