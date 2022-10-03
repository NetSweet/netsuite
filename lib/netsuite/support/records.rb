module NetSuite
  module Support
    module Records
      include Attributes
      include Namespaces::PlatformCore

      def to_record
        attributes.reject { |k,v| self.class.read_only_fields.include?(k) || self.class.search_only_fields.include?(k) }.inject({}) do |hash, (k,v)|
          kname = "#{v.is_a?(NetSuite::Records::NullFieldList) ? v.record_namespace : record_namespace}:"
          kname += k == :klass ? 'class' : NetSuite::Utilities::Strings.lower_camelcase(k.to_s)

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
          hash[:attributes!][kname]['type'] = NetSuite::Utilities::Strings.lower_camelcase(v.type)
        end

        if v.kind_of?(NetSuite::Records::CustomRecordRef) && v.type_id
          hash[:attributes!] ||= {}
          hash[:attributes!][kname] ||= {}
          hash[:attributes!][kname]['typeId'] = NetSuite::Utilities::Strings.lower_camelcase(v.type_id)
        end
      end

      def record_type
        "#{record_namespace}:#{record_type_without_namespace}"
      end

      def netsuite_type
        Records.netsuite_type(self)
      end

      def record_type_without_namespace
        Records.record_type_without_namespace(self)
      end

      def refresh(credentials = {})
        fresh_record = self.class.get(self.internal_id, credentials)

        self.attributes = fresh_record.send(:attributes)

        # gift cards do not have an external ID
        if fresh_record.respond_to?(:external_id)
          self.external_id = fresh_record.external_id
        end

        self.errors = nil

        self
      end

      def self.netsuite_type(obj)
        NetSuite::Utilities::Strings.lower_camelcase(record_type_without_namespace(obj))
      end

      def self.record_type_without_namespace(obj)
        klass = obj.is_a?(Class) ? obj : obj.class
        "#{klass.to_s.split('::').last}"
      end

    end
  end
end
