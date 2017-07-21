module NetSuite
  module Records
    class PricingMatrix < Support::Sublist
      include Namespaces::PlatformCore
      include Support::Records
      include Support::Fields
      include Support::Actions

      actions :get, :get_list, :search

      sublist :pricing, RecordRef

      alias :prices :pricing
    end
  end
end
