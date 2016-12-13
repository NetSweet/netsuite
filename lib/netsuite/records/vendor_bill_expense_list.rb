module NetSuite
  module Records
    class VendorBillExpenseList < Support::Sublist
      include Namespaces::TranPurch

      sublist :expense, VendorBillExpense

      # legacy support
      alias :expenses :expense

    end
  end
end
