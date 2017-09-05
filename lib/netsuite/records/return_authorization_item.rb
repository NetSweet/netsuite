module NetSuite
  module Records
    class ReturnAuthorizationItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranCust

      fields :alt_sales_amt, :amortization_period, :amortization_type, :amount, :bill_variance_status, :catch_up_period,
        :cost_estimate, :cost_estimate_rate, :cost_estimate_type, :days_before_expiration, :defer_rev_rec, :description,
        :gift_cert_from, :gift_cert_message, :gift_cert_recipient_email, :gift_cert_recipient_name, :id, :inventory_detail,
        :is_closed, :is_drop_shipment, :is_taxable, :is_vsoe_bundle, :item_subtype, :item_type, :line, :line_number,
        :matrix_type, :options, :order_line, :print_items, :quantity, :quantity_billed, :quantity_received, :quantity_rev_committed,
        :rate, :rate_schedule, :rev_rec_end_date, :rev_rec_start_date, :tax_rate1, :vsoe_allocation, :vsoe_amount,
        :vsoe_deferral, :vsoe_delivered, :vsoe_is_estimate, :vsoe_permit_discount, :vsoe_price, :vsoe_sop_group

      field :custom_field_list, CustomFieldList

      record_refs :department, :item, :job, :klass, :location, :price, :rev_rec_schedule, :tax_code, :units

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          initialize_from_attributes_hash(attributes_or_record)
        when self.class
          initialize_from_record(attributes_or_record)
        end
      end

      def initialize_from_record(record)
        self.attributes = record.send(:attributes)
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
