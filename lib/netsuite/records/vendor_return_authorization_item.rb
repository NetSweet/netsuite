module NetSuite
  module Records
    class VendorReturnAuthorizationItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranPurch

      fields :amortization_end_date, :amortization_residual, :amount, :bin_numbers, :description,
      :gross_amt, :is_billable, :is_closed, :is_drop_shipment, :line, :order_line, :quantity,
      :rate, :vendor_name

      field :inventory_detail, InventoryDetail

      record_refs :item, :location, :tax_code, :units, :customer

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
