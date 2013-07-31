module NetSuite
  module Records
    class TransferOrder
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranInvt

      actions :get, :add, :delete, :update, :search

      fields :created_date, :last_modified_date, :shipping_cost, :sub_total,
        :status, :ship_address, :fob, :tran_date, :tran_id, :source, :order_status,
        :memo, :ship_date, :tracking_numbers, :linked_tracking_numbers, :ship_complete,
        :alt_shipping_cost, :shipping_tax1_rate, :shipping_tax2_rate, :handling_tax1_rate,
        :handling_tax2_rate, :total, :klass

      field :custom_field_list, CustomFieldList
      field :item_list, TransferOrderItemList
      field :transaction_ship_address, ShipAddress

      record_refs :custom_form, :ship_address_list, :subsidiary, :employee, :department,
        :location, :transfer_location, :ship_method, :shipping_tax_code, :handling_tax_code

      attr_accessor :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.custom_soap_advanced_search_record_type
        'tranSales:TransactionSearchAdvanced'
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end


    end
  end
end
