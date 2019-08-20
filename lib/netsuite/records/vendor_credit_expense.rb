module NetSuite
  module Records
    class VendorCreditExpense
      include Support::Fields
      include Support::Records
      include Namespaces::TranPurch

      fields :order_line,  :line,      :amount,
             :tax_rate1,   :tax_rate2, :tax1_amt,
             :gross_amt,   :memo,      :is_billable,
             :amortiz_start_date,
             :amortization_end_date,
             :amortization_residual

      field :category,            RecordRef
      field :taxCode,             RecordRef
      field :account,             RecordRef
      field :department,          RecordRef
      field :klass,               RecordRef
      field :amortizationSched,   RecordRef
      field :location,            RecordRef
      field :customer,            RecordRef
      field :custom_field_list,   CustomFieldList

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
