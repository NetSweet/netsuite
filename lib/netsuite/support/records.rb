module NetSuite
  module Support
    module Records
      include Attributes

      def to_record
        attributes.inject({}) do |hash, (k,v)|
          hash.store("listRel:#{k.to_s.lower_camelcase}", v)
          hash
        end
      end

      def record_type
        "listRel:#{self.class.to_s.split('::').last}"
      end

    end
  end
end
