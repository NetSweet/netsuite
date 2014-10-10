module NetSuite
  module Records
    class InventoryAssignment
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::PlatformCommon

      fields :expiration_date, :internal_id, :quantity, :quantity_available,
        :receipt_inventory_number

      record_refs :bin_number, :issue_inventory_number, :to_bin_number

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
