module NetSuite
  module Records
    class VendorCreditItem
      include Support::Fields
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

       field :item,                RecordRef
       field :units,               RecordRef
       field :department,          RecordRef
       field :customer,            RecordRef
       field :location,            RecordRef
       field :tax_code,            RecordRef
       field :serial_numbers_list, RecordRefList
       field :inventory_detail,    InventoryDetail
       field :custom_field_list,   CustomFieldList
       field :options,             CustomFieldList

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
