module NetSuite
  module Records
    class SalesOrderItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranSales

      fields :amount, :bin_numbers, :cost_estimate,
        :cost_estimate_type, :defer_rev_rec, :description,
        :expand_item_group, :gift_cert_from, :gift_cert_message,
        :gift_cert_number, :gift_cert_recipient_email,
        :gift_cert_recipient_name, :gross_amt, :is_closed,
        :is_taxable, :line, :order_line, :po_currency, :quantity,
        :quantity_back_ordered, :quantity_billed, :quantity_committed,
        :quantity_fulfilled, :rate, :rev_rec_end_date,
        :rev_rec_start_date, :rev_rec_term_in_months, :serial_numbers,
        :shipping_cost, :tax1_amt, :tax_rate1, :tax_rate2,
        :vsoe_allocation, :vsoe_amount, :vsoe_deferral,
        :vsoe_delivered, :vsoe_permit_discount, :vsoe_price,
        :ship_group

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
