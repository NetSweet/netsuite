module NetSuite
  module Records
    class CustomerDepositApplyList < Support::Sublist
      include Namespaces::TranCust

      sublist :customer_deposit_apply, CustomerDepositApply

      alias :applies :customer_deposit_apply

    end
  end
end
