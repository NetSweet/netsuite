module NetSuite
  module Records
    class PriceList < Support::Sublist
      include Namespaces::ListAcct

      sublist :price, Price
    end
  end
end
