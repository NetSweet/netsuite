module NetSuite
  module Records
    class GiftCertRedemptionList < Support::Sublist
      include Namespaces::TranSales

      sublist :gift_cert_redemption, GiftCertRedemption

      alias :gift_cert_redemptions :gift_cert_redemption
    end
  end
end