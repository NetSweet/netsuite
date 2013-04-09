module NetSuite
  module Records
    class ItemFulfillmentItemList
      include Support::Fields
      include Namespaces::TranSales

      fields :item

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def item=(items)
        case items
        when Hash
          self.items << ItemFulfillmentItem.new(items)
        when Array
          items.each { |item| self.items << ItemFulfillmentItem.new(item) }
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
