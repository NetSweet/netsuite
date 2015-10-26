require 'spec_helper'

describe NetSuite::Records::CreditMemoApplyList do
  let(:apply) { NetSuite::Records::CreditMemoApply.new }

  it 'has all the right fields' do
    [
        :amount, :apply, :apply_date, :currency, :doc, :due, :job, :line, :ref_num, :total, :type
    ].each do |field|
      expect(apply).to have_field(field)
    end
  end

end
