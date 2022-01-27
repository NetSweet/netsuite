require 'spec_helper'

describe NetSuite::Records::ItemOptionCustomField do

  describe ".get" do
    let(:response) do
      NetSuite::Response.new(
        success: true,
        body: {
          label: "Value of Label",
        }
      )
    end

    it "returns a ItemOptionCustomField instance with populated fields" do
      expect(NetSuite::Actions::Get)
        .to receive(:call)
        .with([NetSuite::Records::ItemOptionCustomField, internal_id: 1], {})
        .and_return(response)

      record = NetSuite::Records::ItemOptionCustomField.get(internal_id: 1)
      
      expect(record.label).to eql("Value of Label")
    end
  end

end
