require "spec_helper"

describe NetSuite::Records::EntityCustomField do
  describe ".get" do
    context "success" do
      let(:internal_id) { 1 }
      let(:response) do
        NetSuite::Response.new(
          success: true,
          body: { 
            access_level: "_edit",
            field_type: "_integerNumber",
            label: "Salesforce Customer ID",
            show_in_list: true,
          }
        )
      end

      it "returns a EntityCustomField instance with populated fields" do
        expect(NetSuite::Actions::Get)
          .to receive(:call)
          .with([NetSuite::Records::EntityCustomField, internal_id: internal_id], {})
          .and_return(response)

        record = NetSuite::Records::EntityCustomField.get(internal_id: internal_id)

        expect(record.access_level).to eql("_edit")
        expect(record.field_type).to eql("_integerNumber")
        expect(record.label).to eql("Salesforce Customer ID")
        expect(record.show_in_list).to eq(true)
      end
    end
  end
end
