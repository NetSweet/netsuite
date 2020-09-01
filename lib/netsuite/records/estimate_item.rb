module NetSuite
  module Records
    class EstimateItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranSales

      fields :amount, :cost_estimate,
        :cost_estimate_type, :defer_rev_rec, :description,
        :is_taxable, :line, :quantity,
        :rate, :tax_rate1

      field :custom_field_list, CustomFieldList

      record_refs :item, :job, :price, :tax_code, :units

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
