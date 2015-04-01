module NetSuite
  module Records
    class CustomerPaymentCredit
      include Support::Fields
      include Support::Records
      include Namespaces::TranCust

      fields :amount, :appliedTo, :apply, :creditDate, :currency, :doc, :due,
             :line, :refNum, :total, :type

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
