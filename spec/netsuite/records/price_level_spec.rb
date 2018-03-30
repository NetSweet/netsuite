require 'spec_helper'

describe NetSuite::Records::PriceLevel do
  describe "#initialize" do
    it "behaves appropriately if it gets a hash as attributes[:pricing]" do
      # this is what savon returns if there is only one pricing strategy matrix
      # for the item:
      level = {
        :name => 'Base Price'
      }

      subject = NetSuite::Records::PriceLevel.new(level)
      expect(subject.name).to eq(level[:name])
    end
  end
end
