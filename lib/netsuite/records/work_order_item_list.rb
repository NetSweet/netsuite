module NetSuite
  module Records
    class WorkOrderItemList
      include Support::Fields
      include Namespaces::TranInvt

      fields :item

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def item=(items)
        case items
        when Hash
          self.items << WorkOrderItem.new(items)
        when Array
          items.each { |item| self.items << WorkOrderItem.new(item) }
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
