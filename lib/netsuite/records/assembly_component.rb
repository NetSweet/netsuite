module NetSuite
  module Records
    class AssemblyComponent
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranInvt

      fields :bin_number, :component_numbers, :line_number, :quantity,
        :quantity_on_hand

      field :component_inventory_detail, InventoryDetail

      record_refs :item

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
