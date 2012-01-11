module NetSuite
  module Support
    module Attributes

      def attributes
        @attributes ||= {}
      end
      private :attributes

      def initialize_from_attributes_hash(attributes = {})
        attributes.select { |k,v| self.class.fields.include?(k) }.each do |k,v|
          send("#{k}=", v)
        end
        self.klass = v if attributes[:class]
      end

    end
  end
end
