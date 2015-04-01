require 'spec_helper'

describe NetSuite::Records::CustomerPaymentCredit do
  let(:credit) { NetSuite::Records::CustomerPaymentCredit.new }

  it 'has all the right fields' do
    [
      :amount, :appliedTo, :apply, :creditDate, :currency, :doc, :due, :line, :refNum, :total, :type
    ].each do |field|
      expect(credit).to have_field(field)
    end
  end

end
