module NetSuite
  module Records
    class InventoryItemLocations
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::ListAcct

      fields :location, :quantity_on_hand, :on_hand_value_mli,
        :average_cost_mli, :last_purchase_price_mli, :reorder_point,
        :preferred_stock_level, :lead_time, :default_return_cost,
        :safety_stock_level, :cost, :build_time, :last_invt_count_date,
        :next_invt_count_date, :is_wip, :invt_count_internal, :invt_classification,
        :quantity_on_order, :quantity_committed, :quantity_available,
        :quantity_back_ordered, :fixed_lot_size, :periodic_lot_size_type,
        :periodic_lot_size_days, :backward_consumption_days, :forward_consumption_days


      record_refs :supply_replenishment_level, :alternate_demand_source_item,
        :supply_lot_sizing_method, :demand_source, :location_id

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end


    end
  end
end
