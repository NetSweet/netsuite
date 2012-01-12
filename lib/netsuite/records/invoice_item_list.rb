module NetSuite
  module Records
    class InvoiceItemList
      include Namespaces::TranSales

      def items
        @items ||= []
      end

      def to_record
        { "#{record_namespace}:item" => items.map(&:to_record) }
      end

    end
  end
end
