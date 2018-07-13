require "spec_helper"

describe NetSuite::Records::TransactionColumnCustomField do
  describe ".get" do
    context "success" do
      let(:internal_id) { 1 }
      let(:response) do
        NetSuite::Response.new(
          success: true,
          body: { 
            access_level: "_none",
            field_type: "_decimalNumber",
            label: "Billing System Tax",
          }
        )
      end

      it "returns a TransactionColumnCustomField instance with populated fields" do
        expect(NetSuite::Actions::Get)
          .to receive(:call)
          .with([NetSuite::Records::TransactionColumnCustomField, internal_id: internal_id], {})
          .and_return(response)

        record = NetSuite::Records::TransactionColumnCustomField.get(internal_id: internal_id)

        expect(record.access_level).to eql("_none")
        expect(record.field_type).to eql("_decimalNumber")
        expect(record.label).to eql("Billing System Tax")
      end
    end
  end
end
