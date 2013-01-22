module NetSuite
  module Records
    class InventoryAdjustmentInventory
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranInvt

      fields :line, :description, :quantity_on_hand, :current_value, :adjust_qty_by,
        :bin_numbers, :serial_numbers, :new_quantity, :unit_cost,
        :foreign_currency_unit_cost, :memo, :currency, :expiration_date, :exchange_rate

      record_refs :item, :inventory_detail, :location, :units

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
