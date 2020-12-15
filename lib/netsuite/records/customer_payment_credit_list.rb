module NetSuite
  module Records
    class CustomerPaymentCreditList < Support::Sublist
      include Namespaces::TranCust

      sublist :credit, CustomerPaymentCredit

      alias :credits :credit

    end
  end
end
