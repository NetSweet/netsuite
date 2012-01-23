require 'spec_helper'

describe NetSuite::Records::CreditMemoApply do
  let(:apply) { NetSuite::Records::CreditMemoApply.new }

  it 'has all the right fields' do
    [
      :amount, :apply, :apply_date, :currency, :doc, :due, :job, :line, :ref_num, :total, :type
    ].each do |field|
      apply.should have_field(field)
    end
  end

end
