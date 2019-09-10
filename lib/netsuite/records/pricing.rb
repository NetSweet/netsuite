module NetSuite
  module Records
    class Pricing
      include Support::Fields
      include Support::Records
      include Support::RecordRefs
      include Namespaces::ListAcct

      record_refs :currency, :price_level

      fields :discount

      field :price_list, PriceList

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
