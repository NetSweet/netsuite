module NetSuite
  module Records
    class CustomFieldList
      include Namespaces::PlatformCore

      def initialize(attributes = {})
        case attributes[:custom_field]
        when Hash
          custom_fields << CustomField.new(attributes[:custom_field])
        when Array
          attributes[:custom_field].each { |custom_field| custom_fields << CustomField.new(addressbook) }
        end
      end

      def custom_fields
        @custom_fields ||= []
      end

      def to_record
        { "#{record_namespace}:customField" => custom_fields.map(&:to_record) }
      end

    end
  end
end
