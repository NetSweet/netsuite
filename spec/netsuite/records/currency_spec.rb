require 'spec_helper'

describe NetSuite::Records::Account do
  let(:currency) { NetSuite::Records::Currency.new }

  it 'can be initialized and has fields' do
    expect(currency.class.fields.size).to be > 0

    currency.class.fields.each { |f| expect(currency).to have_field(f) }
  end
end
