module NetSuite
  module Records
    class CustomerPaymentCredit
      include Support::Fields
      include Support::Records
      include Namespaces::TranCust

      fields :amount, :applied_to, :apply, :credit_date, :currency, :doc, :due, :line,
        :ref_num, :total, :type

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
