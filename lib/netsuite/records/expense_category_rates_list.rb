module NetSuite
  module Records
    class ExpenseCategoryRatesList < Support::Sublist
      include Namespaces::ListAcct

      sublist :expense_category, ExpenseCategoryRate
    end
  end
end
