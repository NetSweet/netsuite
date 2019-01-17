module NetSuite
  module Records
    class PromotionsList < Support::Sublist
      include Namespaces::TranSales

      sublist :promotions, Promotions
    end
  end
end