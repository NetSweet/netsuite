module NetSuite
  module Records
    class ItemFulfillmentItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranSales


      fields :job_name, :item_receive, :item_name, :description,
        :location, :on_hand, :quantity, :units_display, :create_po,
        :inventory_detail, :bin_numbers, :serial_numbers, :po_num,
        :order_line, :quantity_remaining, :ship_group, :item_is_fulfilled

      # Don't include class. It will shadow built in method
      record_refs :location, :item, :ship_address,
        :ship_method

      field :options, CustomFieldList
      field :custom_field_list, CustomFieldList

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end


    end
  end
end

