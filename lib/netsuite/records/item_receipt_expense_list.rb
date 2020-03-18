module NetSuite
  module Records
    class ItemReceiptExpenseList < Support::Sublist
      include Namespaces::TranPurch

      sublist :expense, ItemReceiptExpense

      alias :expenses :expense
    end
  end
end
