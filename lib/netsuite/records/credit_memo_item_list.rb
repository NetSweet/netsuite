module NetSuite
  module Records
    class CreditMemoItemList < Support::Sublist
      include Namespaces::TranCust

      sublist :item, CreditMemoItem

      alias :items :item
    end
  end
end
