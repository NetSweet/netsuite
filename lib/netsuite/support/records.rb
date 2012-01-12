module NetSuite
  module Support
    module Records
      include Attributes
      include Namespaces::PlatformCore

      def to_record
        attributes.reject { |k,v| self.class.read_only_fields.include?(k) }.inject({}) do |hash, (k,v)|
          kname = if k == :klass
                    "#{record_namespace}:class"
                  else
                    "#{record_namespace}:#{k.to_s.lower_camelcase}"
                  end
          if v.respond_to?(:internal_id) && v.internal_id
            hash[:attributes!] ||= {}
            hash[:attributes!][kname] ||= {}
            hash[:attributes!][kname]['internalId'] = v.internal_id
          end
          if v.respond_to?(:external_id) && v.external_id
            hash[:attributes!] ||= {}
            hash[:attributes!][kname] ||= {}
            hash[:attributes!][kname]['externalId'] = v.external_id
          end
          if v.kind_of?(NetSuite::Records::RecordRef) && v.type
            hash[:attributes!] ||= {}
            hash[:attributes!][kname] ||= {}
            hash[:attributes!][kname]['type'] = v.type.lower_camelcase
          end
          if Array === v
            v = v.map { |i| i.respond_to?(:to_record) ? i.to_record : i }
          else
            v = v.to_record if v.respond_to?(:to_record)
          end
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
