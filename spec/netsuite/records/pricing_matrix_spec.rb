require 'spec_helper'

describe NetSuite::Records::PricingMatrix do
  describe "#initialize" do
    it "behaves appropriately if it gets a hash as attributes[:pricing]" do
      # this is what savon returns if there is only one pricing strategy matrix
      # for the item:
      matrix = {
        :pricing=> {
          :currency=>"US Dollar",
          :priceLevel=>"Base Price",
          :priceList=>[
            {:price=>{:value=>12.0, :quantity=>0.0}},
            {:price=>{:value=>10.0, :quantity=>10.0}},
            {:price=>{:value=>9.0, :quantity=>100.0}},
            {:price=>{:value=>7.0, :quantity=>5000.0}}
          ]
        }
      }

      subject = NetSuite::Records::PricingMatrix.new({pricing: matrix})
      expect(subject.prices[0].pricing).to eq(matrix[:pricing])
    end
  end
end
