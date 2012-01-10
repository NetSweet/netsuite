module NetSuite
  module Records
    class InvoiceItemList
      include FieldSupport
      include RecordRefSupport

      fields :amount, :amount_ordered, :bin_numbers, :cost_estimate, :cost_estimate_type, :current_percent, :custom_field_list,
        :defer_rev_rec, :description, :gift_cert_from, :gift_cert_message, :gift_cert_number, :gift_cert_recipient_email,
        :gift_cert_recipient_name, :gross_amt, :inventory_detail, :is_taxable, :item_is_fulfilled, :license_code, :line,
        :options, :order_line, :percent_complete, :quantity, :quantity_available, :quantity_fulfilled, :quantity_on_hand,
        :quantity_ordered, :quantity_remaining, :rate, :rev_rec_end_date, :rev_rec_start_date, :serial_numbers, :ship_group,
        :tax1_amt, :tax_rate1, :tax_rate2, :vsoe_allocation, :vsoe_amount, :vsoe_deferral, :vsoe_delivered,
        :vsoe_permit_discount, :vsoe_price

      record_refs :department, :item, :job, :location, :price, :rev_rec_schedule, :ship_address, :ship_method, :tax_code, :units

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
