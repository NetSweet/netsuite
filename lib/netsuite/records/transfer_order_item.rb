module NetSuite
  module Records
    class TransferOrderItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranInvt


      fields :line, :quantity_available, :quantity_on_hand,
        :quantity_back_ordered, :quantity_committed, :quantity_fulfilled,
        :quantity_packed, :quantity_picked, :quantity_received,
        :quantity, :rate, :amount, :description, :serial_numbers,
        :is_closed, :last_purchase_price, :average_cost, :expected_ship_date,
        :expected_receipt_date, :commit_inventory
      
      # Don't include class. It will shadow built in method
      record_refs :item, :units, :department,
        :inventory_detail

      field :options, CustomFieldList
      field :custom_field_list, CustomFieldList

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end


    end
  end
end
