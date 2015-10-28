module NetSuite
  module Records
    class CustomerRefundApplyList < Support::Sublist
      include Namespaces::TranCust

      sublist :apply, CustomerRefundApply

      # for backward compatibility
      def applies
        self.apply
      end
    end

  end
end
