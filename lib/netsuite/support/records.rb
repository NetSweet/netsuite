module NetSuite
  module Support
    module Records
      include Attributes

      def to_record
        attributes.inject({}) do |hash, (k,v)|
          hash.store("#{record_namespace}:#{k.to_s.lower_camelcase}", v)
          hash
        end
      end

      def record_type
        "#{record_namespace}:#{self.class.to_s.split('::').last}"
      end

      def record_namespace
        'platformCore'
      end

    end
  end
end
