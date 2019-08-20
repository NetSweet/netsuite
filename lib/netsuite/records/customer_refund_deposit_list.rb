module NetSuite
  module Records
    class CustomerRefundDepositList < Support::Sublist
      include Namespaces::TranCust

      sublist :customer_refund_deposit, CustomerRefundDeposit

      alias :deposits :customer_refund_deposit
    end
  end
end
