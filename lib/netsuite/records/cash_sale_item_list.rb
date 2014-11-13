module NetSuite
  module Records
    class CashSaleItemList
      include Namespaces::TranCust

      def initialize(attributes = {})
        case attributes[:item]
        when Hash
          items << CashSaleItem.new(attributes[:item])
        when Array
          attributes[:item].each { |item| items << CashSaleItem.new(item) }
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

