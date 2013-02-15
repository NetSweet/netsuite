module NetSuite
  module Records
    class ReturnAuthorizationItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranCust

      fields :order_line, :line, :quantity, :quantity_received, :quantity_billed,
        :inventory_detail, :description, :serial_numbers, :rate, :amount,
        :rev_rec_term_in_months, :defer_rev_rec, :is_closed, :is_drop_shipment,
        :cost_estimate_type, :cost_estimate, :rev_rec_start_date, :rev_rec_end_date,
        :tax_rate1, :tax_rate2, :tax1_amt, :gross_amt, :is_taxable, :gift_cert_from,
        :gift_cert_recipient_name, :gift_cert_recipient_email, :gift_cert_message,
        :gift_cert_number, :vsoe_sop_group, :vsoe_is_estimate, :vsoe_price, :vsoe_amount,
        :alt_sales_amt, :vsoe_allocation, :vsoe_deferral, :vsoe_permit_discount,
        :vsoe_delivered

      record_refs :job, :item, :units, :price, :department, :klass, :location, :rev_rec_schedule,
        :tax_code

      field :options, CustomFieldList
      field :custom_field_list, CustomFieldList

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end


    end
  end
end
