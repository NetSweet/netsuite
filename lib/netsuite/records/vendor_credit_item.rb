module NetSuite
  module Records
    class VendorCreditItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranPurch

      fields :vendor_name, :line,        :order_line,
             :quantity,    :description, :rate,
             :amount,      :bin_numbers, :tax_rate1,
             :tax_rate2,   :gross_amt,   :tax1_amt,
             :klass,       :is_billable, :amortization_sched,
             :amortiz_start_date,
             :amortization_end_date,
             :amortization_residual

      field :serial_numbers_list, RecordRefList
      field :inventory_detail,    InventoryDetail
      field :custom_field_list,   CustomFieldList
      field :options,             CustomFieldList

      record_refs :item, :units, :department, :customer, :location, :tax_code, :klass

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
