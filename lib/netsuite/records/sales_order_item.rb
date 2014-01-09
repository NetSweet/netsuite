module NetSuite
  module Records
    class SalesOrderItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranSales

      fields :quantity_available, :quantity_on_hand, :quantity, :description,
        :rate, :serial_numbers, :amount, :is_taxable, :license_code, :alt_sales_amount,
        :create_wo, :po_vendor, :po_currency, :po_rate, :rev_rec_start_date,
        :rev_rec_term_in_months, :rev_rec_end_date, :defer_rev_rec, :is_closed,
        :from_job, :gross_amount, :is_estimate, :line, :percent_complete, :cost_estimate,
        :quantity_back_ordered, :quantity_billed, :quantity_committed, :quantity_fulfilled,
        :quantity_packed, :quantity_picked, :tax1_amt, :tax_rate1, :tax_rate2, :gift_cert_from,
        :gift_cert_recipient_name, :gift_cert_recipient_email, :gift_cert_message, :gift_cert_number,
        :ship_group, :item_is_fulfilled, :vsoe_is_estimate, :vsoe_price, :vsoe_allocation,
        :vsoe_deferral, :vsoe_permit_discount, :vsoe_delivered, :expected_ship_date, :klass

      record_refs :job, :item, :units, :price, :department, :location, :created_po,
        :po_vendor, :rev_rec_schedule, :billing_schedule, :tax_code, :ship_address,
        :ship_method


      field :options, CustomFieldList
      field :custom_field_list, CustomFieldList

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        if rec["#{record_namespace}:options"]
          rec["#{record_namespace}:options!"] = rec.delete("#{record_namespace}:options")
        end
        rec
      end

    end
  end
end
