require 'spec_helper'

describe NetSuite::Records::GiftCertRedemptionList do
  let(:list) { NetSuite::Records::GiftCertRedemptionList.new }

  it 'has a gift_cert_redemptions attribute' do
    expect(list.gift_cert_redemptions).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.gift_cert_redemptions << NetSuite::Records::GiftCertRedemption.new(
        :auth_code_applied => 20
      )
    end

    it 'can represent itself as a SOAP record' do
      record =  {
        'tranSales:giftCertRedemption' => [{
          'tranSales:authCodeApplied' => 20
        }]
      }
      expect(list.to_record).to eql(record)
    end
  end
end