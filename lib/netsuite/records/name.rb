module NetSuite
  module Records
    class Name
      include Support::Fields
      include Support::Records
      #include Namespaces::PlatformCore

      attr_accessor :attributes

      def initialize(attributes = {})
        binding.pry
        @value   = attributes.delete(:value) || attributes.delete(:@value)
        @type        = attributes.delete(:type) || attributes.delete(:"@xsi:type")
        self.attributes = attributes
      end

      def value
        attributes[:value]
      end

    end
  end
end
