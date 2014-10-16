module NetSuite
  module Records
    class CustomField
      include Support::Fields
      include Support::Records

      attr_reader :internal_id,
                  :script_id
      attr_accessor :type

      def initialize(attributes = {})
        @script_id = attributes.delete(:script_id) || attributes.delete(:@script_id)
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
