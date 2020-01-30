module NetSuite
  module Records
    class ExpenseReportExpenseList < Support::Sublist
      include Namespaces::TranEmp

      sublist :expense, ExpenseReportExpense
    end
  end
end
