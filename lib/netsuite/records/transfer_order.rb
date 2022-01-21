module NetSuite
  module Records
    class TransferOrder
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranInvt

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :alt_shipping_cost, :created_date, :firmed, :fob, :handling_tax1_rate,
             :handling_tax2_rate, :last_modified_date, :linked_tracking_numbers,
             :memo, :ship_complete, :ship_date, :ship_is_residential, :shipping_cost,
             :shipping_tax1_rate, :shipping_tax2_rate, :source, :status, :sub_total,
             :total, :tracking_numbers, :tran_date, :tran_id, :order_status, :use_item_cost_as_transfer_cost

      record_refs :transfer_location, :shipping_tax_code, :subsidiary, :shipping_address,
                  :ship_method, :employee, :handling_tax_code,
                  :location, :custom_form, :department, :klass, :ship_address_list

      field :custom_field_list,   CustomFieldList
      field :item_list,           TransferOrderItemList

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.search_class_name
        "Transaction"
      end

      def self.search_class_namespace
        'tranSales'
      end

    end
  end
end
