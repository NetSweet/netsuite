module NetSuite
  module Records
    class CustomField
      include Support::Fields
      include Support::Records

      attr_reader :internal_id, :type

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @type        = attributes.delete(:type) || attributes.delete(:"@xsi:type")
        self.attributes = attributes
      end

      def value
        attributes[:value]
      end

    end
  end
end
