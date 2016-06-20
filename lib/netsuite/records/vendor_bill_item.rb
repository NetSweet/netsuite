module NetSuite
  module Records
    class VendorBillItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranPurch

      fields  :amortization_end_date, :amortization_residual, :amortiz_start_date, :bin_numbers,  :bill_variance_status,
              :description, :expiration_date, :gross_amt, :inventory_detail, :is_billable, :landed_cost, :line,
              :order_doc, :order_line, :quantity, :serial_numbers, :tax_rate_1, :tax_rate_2, :tax_1_amt, :vendor_name,
              :rate

      field :bill_receipts_list,  RecordRefList
      field :custom_field_list,   CustomFieldList
      field :options,             CustomFieldList

      read_only_fields :amount

      record_refs  :amortization_sched, :klass, :customer, :department, :item, :landed_cost_category, :location,
                   :tax_code, :units

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
