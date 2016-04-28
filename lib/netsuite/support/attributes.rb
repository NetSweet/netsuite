module NetSuite
  module Support
    module Attributes

      def attributes
        @attributes ||= {}
      end

      def attributes=(attributes)
        @attributes = attributes
      end

      def initialize_from_attributes_hash(attributes = {})
        attributes.select { |k,v| self.class.fields.include?(k) }.each do |k,v|
          send("#{k}=", v)
        end
        self.klass = attributes[:class] if attributes[:class] && self.respond_to?(:klass)
      end

    end
  end
end
