module NetSuite
  module Records
    class CashRefundItemList
      include Support::Fields
      include Namespaces::TranCust

      fields :item

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def item=(items)
        case items
        when Hash
          self.items << CashRefundItem.new(items)
        when Array
          items.each { |item| self.items << CashRefundItem.new(item) }
        end
      end

      def items
        @items ||= []
      end

      def to_record
        { "#{record_namespace}:item" => items.map(&:to_record) }
      end

    end
  end
end

