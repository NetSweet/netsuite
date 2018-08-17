require 'spec_helper'

describe NetSuite::Records::BinNumber do
  it "has all the right fields" do
    bin_number = described_class.new

    [:preferred_bin, :location].each do |field|
      expect(bin_number).to have_field(field)
    end
  end

  it "has all the right record refs" do
    bin_number = described_class.new

    expect(bin_number).to have_record_ref(:bin_number)
  end

  it "has the right namespace" do
    bin_number = described_class.new

    expect(bin_number.record_namespace).to eq('listAcct')
  end
end
