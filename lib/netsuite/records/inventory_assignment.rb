module NetSuite
  module Records
    class InventoryAssignment
      include Support::Records
      include Support::RecordRefs
      include Support::Fields
      include Namespaces::PlatformCommon

      fields :date_time, :quantity, :quantity_available, :expiration_date,
        :receipt_inventory_number

      record_refs :bin_number, :issue_inventory_number, :to_bin_number, :inventory_status

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
