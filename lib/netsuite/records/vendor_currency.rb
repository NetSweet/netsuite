module NetSuite
  module Records
    class VendorCurrency
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::ListRel

      fields :balance, :consol_balance, :consol_deposit_balance, :consol_overdue_balance,
             :consol_unbilled_orders, :deposit_balance, :display_symbol, :overdue_balance,
             :override_currency_format, :symbol_placement, :unbilled_orders

      record_refs :currency

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          initialize_from_attributes_hash(attributes_or_record)
        when self.class
          initialize_from_record(attributes_or_record)
        end
      end

    end
  end
end
