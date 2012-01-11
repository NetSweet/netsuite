module NetSuite
  module Records
    class InvoiceItemList
      include Namespaces::TranSales

      def items
        @items ||= []
      end
      private :items

      def add_item(item, attributes = {})
        attributes.merge!(:item => item)
        items << InvoiceItem.new(attributes)
      end

      def to_record
        { "#{record_namespace}:item" => items.map(&:to_record) }
      end

    end
  end
end
