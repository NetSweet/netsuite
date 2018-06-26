require 'spec_helper'

describe NetSuite::Records::PricingMatrix do
  describe "#initialize" do
    it "behaves appropriately if it gets a hash as attributes[:pricing]" do
      # this is what savon returns if there is only one pricing strategy matrix
      # for the item:
      matrix = [
        {
          currency: { internal_id: 1 },
          price_level: { internal_id: 1 },
          price_list: {
            price: [
              {
                value: 25.0,
                quantity: 0
              }
            ]
          }
        }
      ]

      subject = described_class.new({pricing: matrix})
      expect(subject.pricing[0]).to be_kind_of(NetSuite::Records::Pricing)
    end
  end
end
