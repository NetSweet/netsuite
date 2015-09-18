module NetSuite
  module Records
    class CreditMemoApplyList < Support::Sublist
      include Namespaces::TranCust

      sublist :apply, CreditMemoApply

      # for backward compatibility
      def applies
        self.apply
      end

    end
  end
end
\
