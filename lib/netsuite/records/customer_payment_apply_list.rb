module NetSuite
  module Records
    class CustomerPaymentApplyList < Support::Sublist
      include Namespaces::TranCust

      sublist :apply, CustomerPaymentApply

      alias :applies :apply

    end
  end
end
