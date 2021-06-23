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
          # if k.to_s == "null_field_list"  # new
          #   v.each do |name|
          #     binding.pry
          #     send("name=", name)
          #   end
          # else 
            #send("#{k}=", v)
            binding.pry
            send("#{k}=", k.to_s == "null_field_list" ? v.name : v)
          # end
        end
        self.klass = attributes[:class] if attributes[:class]
      end

    end
  end
end
