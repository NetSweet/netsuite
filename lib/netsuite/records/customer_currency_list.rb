module NetSuite
  module Records
    class CustomerCurrencyList < Support::Sublist
      include Namespaces::ListRel

      sublist :currency, NetSuite::Records::CustomerCurrency
    end
  end
end
