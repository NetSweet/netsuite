require "spec_helper"

describe NetSuite::Records::TransactionBodyCustomField do
  describe ".get" do
    context "success" do
      let(:internal_id) { 1 }
      let(:response) do
        NetSuite::Response.new(
          success: true,
          body: {
            access_level: "_edit",
            field_type: "_freeFormText",
            label: "Billing System Subdomain",
          }
        )
      end

      it "returns a TransactionColumnCustomField instance with populated fields" do
        expect(NetSuite::Actions::Get)
          .to receive(:call)
          .with([NetSuite::Records::TransactionBodyCustomField, internal_id: internal_id], {})
          .and_return(response)

        record = NetSuite::Records::TransactionBodyCustomField.get(internal_id: internal_id)

        expect(record.access_level).to eql("_edit")
        expect(record.field_type).to eql("_freeFormText")
        expect(record.label).to eql("Billing System Subdomain")
      end
    end
  end
end
