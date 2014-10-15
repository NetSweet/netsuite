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
        { "#{record_namespace}:item" => items.map(&:to_record) }
      end
    end
  end
end
