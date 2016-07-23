require 'spec_helper'

describe NetSuite::Records::GiftCertRedemption do
  let(:redemption) { NetSuite::Records::GiftCertRedemption.new }

  it 'has all the right fields' do
    [
      :auth_code_amt_remaining, :auth_code_applied, :gift_cert_available
    ].each do |field|
      expect(redemption).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :auth_code
    ].each do |record_ref|
      expect(redemption).to have_record_ref(record_ref)
    end
  end
end