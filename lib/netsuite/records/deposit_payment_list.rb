module NetSuite
  module Records
    class DepositPaymentList < Support::Sublist
      include Namespaces::TranBank

      sublist :deposit_payment, DepositPayment

      alias :deposit_payments :deposit_payment

      # legacy support
      alias :payments :deposit_payment
    end
  end
end
