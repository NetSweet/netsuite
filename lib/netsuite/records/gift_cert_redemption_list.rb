module NetSuite
  module Records
    class GiftCertRedemptionList < Support::Sublist
      include Namespaces::TranSales

      sublist :gift_cert_redemption, GiftCertRedemption

    end
  end
end





