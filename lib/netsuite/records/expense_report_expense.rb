module NetSuite
  module Records
    class ExpenseReportExpense
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranEmp

      actions :get, :get_list, :add, :delete, :update, :upsert

      fields :amount, :exchange_rate, :expense_date, :foreign_amount, :gross_amt, :is_billable, :is_non_reimbursable, :line, :memo,
        :quantity, :rate, :receipt, :ref_number, :tax_1_amt, :tax_rate_1, :tax_rate_2

      record_refs :category, :currency, :customer, :department, :location

    end
  end
end
