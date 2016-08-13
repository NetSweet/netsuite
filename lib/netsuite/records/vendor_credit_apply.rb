module NetSuite
  module Records
    class VendorCreditApply
      include Support::Fields
      include Namespaces::TranPurch

      fields :apply,    :apply_date,    :doc,
             :line,     :type,          :total,
             :due,      :currency,      :amount

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
