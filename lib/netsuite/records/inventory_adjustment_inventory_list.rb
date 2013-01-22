module NetSuite
  module Records
    class InventoryAdjustmentInventoryList
      include Support::Fields
      include Namespaces::TranInvt

      def initialize(attributes = {})
        case attributes[:inventory]
        when Hash
          inventory << InventoryAdjustmentInventory.new(attributes[:inventory])
        when Array
          attributes[:inventory].each { |inv| inventory << InventoryAdjustmentInventory.new(inv) }
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
