module NetSuite
  module Records
    class DepositPaymentList < Support::Sublist
      include Namespaces::TranBank

      sublist :deposit_payment, DepositPayment

      # legacy support
      def payments
        self.deposit_payment
      end

    end
  end
end
