module NetSuite
  module Records
    class CreditMemoItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranCust

      fields :amount, :bin_numbers, :cost_estimate, :cost_estimate_type, :defer_rev_rec, :description, :gift_cert_from,
        :gift_cert_message, :gift_cert_number, :gift_cert_recipient_email, :gift_cert_recipient_name, :gross_amt, :is_taxable,
        :line, :order_line, :quantity, :rate, :rev_rec_end_date, :rev_rec_start_date, :rev_rec_term_in_months, :serial_numbers,
        :tax1_amt, :tax_rate1, :tax_rate2, :vsoe_allocation, :vsoe_amount, :vsoe_deferral, :vsoe_delivered,
        :vsoe_permit_discount, :vsoe_price

      field :custom_field_list, CustomFieldList
      field :inventory_detail,  InventoryDetail

      record_refs :department, :item, :job, :klass, :location, :price, :rev_rec_schedule, :tax_code, :units

      def initialize(attributes = {})
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
