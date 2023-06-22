module NetSuite
  module Records
    class SerializedInventoryItemLocation
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::ListAcct

      fields :average_cost_mil, :backward_consumption_days, :build_time,
      :cost, :costing_lot_size, :default_return_cost, :demand_time_force,
      :fixed_lot_size, :forward_consumption_days, :invt_count_interval,
      :is_wip, :last_invt_count_date, :last_purchase_price_mli, :lead_time,
      :location, :next_invt_count_date, :on_hand_value_mli,
      :periodic_lot_size_days, :preferred_stock_level, :quantity_available,
      :quantity_back_ordered, :quantity_committed, :quantity_on_hand,
      :quantity_on_order, :reorder_point, :reschedule_in_days,
      :reschedule_out_days, :safety_stock_level, :serial_numbers

      # field :invt_classification, ItemInvtClassification
      # field :periodic_lot_size_type, PeriodicLotSizeType

      record_refs :alternate_demand_source_item, :demand_source, :inventory_cost_template,
      :location_id, :supply_lot_sizing_method, :supply_replenishment_method, :supply_type

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
