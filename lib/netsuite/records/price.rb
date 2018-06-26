module NetSuite
  module Records
    class Price
      include Support::Fields
      include Support::Records
      include Namespaces::ListAcct

      fields :value, :quantity

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
