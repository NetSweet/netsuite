module NetSuite
  module Records
    class CustomerPaymentCreditList < Support::Sublist
      include Namespaces::TranCust

      sublist :credit, CustomerPaymentCredit

      # for backward compatibility
      def credits
        self.credit
      end
    end

  end
end
