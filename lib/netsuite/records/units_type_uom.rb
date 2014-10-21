module NetSuite
  module Records
    class UnitsTypeUom
      include Support::Fields
      include Support::Records
      include Namespaces::ListAcct

      fields :abbreviation, :base_unit, :conversion_rate, :plural_abbreviation,
        :plural_name, :unit_name

      attr_reader   :internal_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
