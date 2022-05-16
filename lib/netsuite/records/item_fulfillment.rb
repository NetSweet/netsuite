module NetSuite
  module Records
    class ItemFulfillment
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranSales

      actions :get, :get_list, :add, :initialize, :update, :delete, :search, :upsert, :upsert_list

      fields :created_from_ship_group, :tran_date, :tran_id, :shipping_cost, :memo, :ship_company, :ship_attention, :ship_addr1,
        :ship_addr2, :ship_city, :ship_state, :ship_zip, :ship_phone, :ship_is_residential,
        :ship_status, :last_modified_date, :created_date, :status

      read_only_fields :handling_cost

      record_refs :custom_form, :entity, :created_from, :ship_carrier, :ship_method,
        :ship_address_list, :klass, :ship_country

      # NOTE API version < 2015_1 only
      field :transaction_ship_address, ShipAddress

      # NOTE API version >= 2015_1
      field :shipping_address,         Address

      field :item_list,                ItemFulfillmentItemList
      field :package_list,             ItemFulfillmentPackageList
      field :package_fed_ex_list,      ItemFulfillmentPackageFedExList      
      field :package_ups_list,         ItemFulfillmentPackageUpsList
      field :package_usps_list,        ItemFulfillmentPackageUspsList
      field :custom_field_list,        CustomFieldList

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)

        if !attributes.empty? && attributes[:package_ups_list]
          attributes[:package_list] ||= {}
          attributes[:package_list].merge! attributes[:package_ups_list]
        end

        initialize_from_attributes_hash(attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end

      def self.search_class_name
        "Transaction"
      end
    end
  end
end
