module NetSuite
  module Records
    class CustomerRefundDeposit
      include Support::Fields
      include Support::Records
      include Namespaces::TranCust

      fields :amount, :apply, :currency, :deposit_date, :doc, :line, :ref_num, :remaining, :total

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
