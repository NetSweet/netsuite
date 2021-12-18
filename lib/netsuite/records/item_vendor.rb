module NetSuite
  module Records
    class ItemVendor
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::ListAcct

      fields :purchase_price,
            :preferred_vendor,
            :vendor_code,
            :vendor_currency_name

      record_refs :schedule,
                  :subsidiary,
                  :vendor,
                  :vendor_currency

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
