module NetSuite
  module Records
    class PricingMatrix < Support::Sublist
      include Namespaces::PlatformCore

      sublist :pricing, RecordRef

      alias :prices :pricing
    end
  end
end
