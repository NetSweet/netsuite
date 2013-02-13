module NetSuite
  module Records
    class ItemFulfillment
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranSales

      actions :get, :add, :update, :delete

      fields :created_date, :last_modifiedDate, :created_from_ship_group,
        :transaction_ship_address, :ship_address, :ship_status, :saturday_delivery_ups,
        :send_ship_notify_email_ups, :send_backup_email_ups, :ship_notify_email_address_ups,
        :ship_notify_email_address_2_ups, :backup_email_address_ups, :ship_notify_email_message_ups,
        :third_party_acct_ups, :third_party_zipcode_ups, :third_party_country_ups, :third_party_type_ups,
        :parties_to_transaction_ups, :export_type_ups, :method_of_transport_ups, :carrier_id_ups,
        :entry_number_ups, :inbond_code_ups, :is_routed_export_transaction_ups, :license_number_ups,
        :license_date_ups, :license_exception_ups, :ecc_number_ups, :recipient_tax_id_ups,
        :blanket_start_date_ups, :blanket_end_date_ups, :shipment_weight_ups, :saturday_delivery_fed_ex,
        :saturday_pickup_fedex, :send_ship_notify_email_fed_ex, :send_backup_email_fed_ex,
        :signature_home_delivery_fed_ex, :ship_notify_email_address_fed_ex, :backup_email_address_fed_ex,
        :ship_date_fed_ex, :home_delivery_type_fed_ex, :home_delivery_date_fed_ex,
        :booking_cofirmation_num_fed_ex, :b13a_filing_option_fed_ex, :b13a_statement_data_fed_ex,
        :third_party_acct_fed_ex, :third_party_country_fed_ex, :third_party_type_fed_ex,
        :shipment_weight_fed_ex, :terms_of_sale_fed_ex, :terms_freight_charge_fed_ex,
        :terms_insurance_charge_fed_ex, :tran_date, :tran_id, :generate_integrated_shipper_label,
        :shipping_cost, :handling_cost, :memo, :package_list, :package_ups_list, :package_usps_list,
        :package_fed_ex_list, :item_list, :ship_group_list

      field :custom_field_list, CustomFieldList
      field :item_list, ItemFulfillmentItemList

      record_refs :custom_form, :posting_period, :entity, :created_from, :partner,
        :ship_address_list, :ship_method, :transfer_location


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
