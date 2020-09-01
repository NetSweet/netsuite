module NetSuite
  module Records
    class EstimateItemList < Support::Sublist
      include Namespaces::TranSales

      sublist :item, EstimateItem

      alias :items :item
    end
  end
end
