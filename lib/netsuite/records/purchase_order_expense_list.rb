module NetSuite
  module Records
    class PurchaseOrderExpenseList < Support::Sublist
      include Namespaces::TranPurch

      sublist :expense, PurchaseOrderExpense

      alias :expenses :expense
    end
  end
end
