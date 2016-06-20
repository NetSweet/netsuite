module NetSuite
  module Records
    class ExpenseReportExpenseList
      include Support::Fields
      include Namespaces::TranEmp

      fields :replace_all

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
        case attributes[:expense]
          when Hash
            expenses << ExpenseReportExpense.new(attributes[:expense])
          when Array
            attributes[:expense].each { |expense| expenses << ExpenseReportExpense.new(expense) }
        end
      end

      def expenses
        @expenses ||= []
      end

      def to_record
        { "#{record_namespace}:expenseReportExpense" => expenses.map(&:to_record) }
      end
    end
  end
end
