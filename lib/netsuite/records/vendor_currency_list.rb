module NetSuite
  module Records
    class VendorCurrencyList < Support::Sublist
      include Namespaces::ListRel

      sublist :vendor_currency, NetSuite::Records::VendorCurrency
    end
  end
end
