module NetSuite
  module Records
  	class ItemFulfillment
		include Support::Fields
		include Support::RecordRefs
		include Support::Records
		include Support::Actions
		include Namespaces::TranSales

  		actions :get, :initialize, :delete

      fields :tran_date, :tran_id, :shipping_cost, :memo, :ship_company, :ship_attention, :ship_addr1,
        :ship_addr2, :ship_city, :ship_state, :ship_zip, :ship_phone, :ship_is_residential

      read_only_fields :handling_cost

      record_refs :custom_form, :entity, :created_from, :ship_carrier, :ship_method, 
        :ship_address_list, :klass, :ship_country

      field :transaction_ship_address, ShipAddress
      field :item_list,                ItemFulfillmentItemList
      field :custom_field_list,        CustomFieldList

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
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