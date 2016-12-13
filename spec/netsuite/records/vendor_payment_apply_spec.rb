require 'spec_helper'

describe NetSuite::Records::VendorPaymentApply do
  let(:apply) { NetSuite::Records::VendorPaymentApply.new }

  it 'has all the right fields' do
    [
      :amount, :apply, :apply_date, :currency, :disc, :disc_amt, :disc_date, :doc, :due, :line,
      :job, :ref_num, :total, :type
    ].each do |field|
      expect(apply).to have_field(field)
    end
  end

end
