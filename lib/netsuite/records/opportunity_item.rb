module NetSuite
  module Records
    class OpportunityItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranSales

      fields :alt_sales_amt, :amount, :cost_estimate, :cost_estimate_type,
        :description, :expected_ship_date, :from_job, :gross_amt, :is_estimate,
        :is_taxable, :line, :quantity, :quantity_available, :quantity_on_hand,
        :rate, :rev_rec_term_in_months,
        :tax1_amt, :tax_rate1, :tax_rate2

      field :custom_field_list, CustomFieldList

      record_refs :department, :item, :job, :klass, :location, :price, :tax_code, :units

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
