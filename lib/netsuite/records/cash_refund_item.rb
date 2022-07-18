module NetSuite
  module Records
    class CashRefundItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranCust

      fields :amount, :gross_amt, :rate, :quantity, :is_taxable, :order_line, :line, :description
      field :custom_field_list,    CustomFieldList

      record_refs :item, :klass, :price

      def initialize(attributes_or_record = {})
        initialize_from_attributes_hash(attributes_or_record)
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
