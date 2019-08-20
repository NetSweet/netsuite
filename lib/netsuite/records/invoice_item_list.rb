module NetSuite
  module Records
    class InvoiceItemList < Support::Sublist
      include Namespaces::TranSales

      sublist :item, InvoiceItem

      # legacy support
      def items
        self.item
      end

    end
  end
end
