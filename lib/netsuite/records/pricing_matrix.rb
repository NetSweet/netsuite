module NetSuite
  module Records
    class PricingMatrix < Support::Sublist
      include NetSuite::Namespaces::ListAcct

      sublist :pricing, NetSuite::Records::Pricing

      alias :prices :pricing
    end
  end
end
