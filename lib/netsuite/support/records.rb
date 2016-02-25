module NetSuite
  module Support
    module Records
      include Attributes
      include Namespaces::PlatformCore

      def to_record
        attributes.reject { |k,v| self.class.read_only_fields.include?(k) }.inject({}) do |hash, (k,v)|
          kname = "#{record_namespace}:"
          kname += k == :klass ? 'class' : k.to_s.lower_camelcase

          to_attributes!(hash, kname, v)

          if Array === v
            v = v.map { |i| i.respond_to?(:to_record) ? i.to_record : i }
          elsif v.respond_to?(:to_record)
            v = v.to_record
          end

          hash[kname] = v
          hash
        end
      end

      def to_attributes!(hash, kname, v)
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

        if v.kind_of?(NetSuite::Records::CustomRecordRef) && v.type_id
          hash[:attributes!] ||= {}
          hash[:attributes!][kname] ||= {}
          hash[:attributes!][kname]['typeId'] = v.type_id.lower_camelcase
        end
      end

      def record_type
        "#{record_namespace}:#{record_type_without_namespace}"
      end

      def type
        record_type_without_namespace.downcase
      end

      def record_type_without_namespace
        "#{self.class.to_s.split('::').last}"
      end

      def refresh(credentials = {})
        fresh_record = self.class.get(self.internal_id, credentials)

        self.attributes = fresh_record.send(:attributes)
        self.external_id = fresh_record.external_id
        self.errors = nil

        self
      end

    end
  end
end
