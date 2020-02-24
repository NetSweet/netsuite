module NetSuite
  module Records
    class VendorCreditExpense
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranPurch

      fields :order_line,  :line,      :amount,
             :tax_rate1,   :tax_rate2, :tax1_amt,
             :gross_amt,   :memo,      :is_billable,
             :amortiz_start_date,
             :amortization_end_date,
             :amortization_residual

      field :custom_field_list,   CustomFieldList

      record_refs :account, :category, :customer, :department, :item, :location, :units, :tax_code

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
