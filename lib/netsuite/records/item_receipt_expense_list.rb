module NetSuite
  module Records
    class ItemReceiptExpenseList
      include Support::Fields
      include Namespaces::TranInvt

      fields :replace_all

      def initialize(attributes = {})
        case attributes[:expense]
        when Hash
          item << ItemReceiptExpense.new(attributes[:expense])
        when Array
          attributes[:expense].each { |inv| expense << ItemReceiptExpense.new(inv) }
        end
      end

      def expense
        @expense ||= []
      end

      def to_record
        { "#{record_namespace}:expense" => item.map(&:to_record) }
      end


    end
  end
end
