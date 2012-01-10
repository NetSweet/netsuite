module NetSuite
  module Support
    module Records
      include Attributes
      include Namespaces::PlatformCore

      def to_record
        attributes.inject({}) do |hash, (k,v)|
          kname = "#{record_namespace}:#{k.to_s.lower_camelcase}"
          if v.respond_to?(:internal_id) && v.internal_id
            hash[:attributes!] ||= {}
            hash[:attributes!][kname] ||= {}
            hash[:attributes!][kname]['internalId'] = v.internal_id
          end
          v = v.to_record if v.respond_to?(:to_record)
          hash[kname] = v
          hash
        end
      end

      def record_type
        "#{record_namespace}:#{self.class.to_s.split('::').last}"
      end

    end
  end
end
