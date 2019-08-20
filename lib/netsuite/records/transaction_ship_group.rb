module NetSuite
  module Records
    class TransactionShipGroup
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranSales

      fields :destination_address,
        :handling_rate,
        :handling_tax2_amt,
        :handling_tax2_rate,
        :handling_tax_amt,
        :handling_tax_rate,
        :id,
        :is_fulfilled,
        :is_handling_taxable,
        :is_shipping_taxable,
        :shipping_method,
        :shipping_rate,
        :shipping_tax2_amt,
        :shipping_tax2_rate,
        :shipping_tax_amt,
        :shipping_tax_rate,
        :source_address,
        :weight

      record_refs :destination_address_ref,
        :handling_tax_code,
        :shipping_method_ref,
        :shipping_tax_code,
        :source_address_ref

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
