module NetSuite
  module Records
    class CreditMemoItemList
      include Namespaces::TranCust

      def initialize(attributes = {})
        case attributes[:item]
        when Hash
          items << CreditMemoItem.new(attributes[:item])
        when Array
          attributes[:item].each { |item| items << CreditMemoItem.new(item) }
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
