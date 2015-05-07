module NetSuite
  module Records
    class VendorBillExpenseList
      include Support::Fields
      include Namespaces::TranPurch

      fields :expense

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def expense=(expenses)
        case expenses
          when Hash
            self.expenses << VendorBillExpense.new(expenses)
          when Array
            expenses.each { |expense| self.expenses << VendorBillExpense.new(expense) }
        end
      end

      def expenses
        @expenses ||= []
      end

      def to_record
        { "#{record_namespace}:expense" => expenses.map(&:to_record) }
      end

    end
  end
end
