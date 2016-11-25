module NetSuite
  module Records
    class VendorCreditExpenseList < Support::Sublist
      include Namespaces::TranPurch

      sublist :expense, VendorCreditExpense

      alias :expenses :expense

    end
  end
end
