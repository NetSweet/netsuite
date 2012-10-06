module NetSuite
  module Records
    class SalesOrderItemList
      include Namespaces::TranSales

      def initialize(attributes = {})
        case attributes[:item]
        when Hash
          items << SalesOrderItem.new(attributes[:item])
        when Array
          attributes[:item].each { |item| items << SalesOrderItem.new(item) }
        end
      end

      def items
        @items ||= []
      end

      def to_record
        items.map do |item|
          { "#{record_namespace}:item" => item.to_record }
        end
      end

    end
  end
end
