module NetSuite
  module Records
    class InventoryTransferInventoryList
      include Support::RecordRefs
      include Support::Records
      include Support::Fields
      include Namespaces::TranInvt

      fields :inventory

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def inventory=(items)
        case items
        when Hash
          self.inventory << InventoryTransferInventory.new(items)
        when Array
          items.each { |item| self.inventory << InventoryTransferInventory.new(item) }
        end
      end

      def inventory
        @inventory ||= []
      end

      def to_record
        { "#{record_namespace}:inventory" => inventory.map(&:to_record) }
      end
    end
  end
end
