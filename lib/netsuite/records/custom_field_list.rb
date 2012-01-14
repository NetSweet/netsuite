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
        custom_fields.map do |custom_field|
          {
            "#{record_namespace}:customField" => custom_field.to_record,
            :attributes! => {
              "#{record_namespace}:customField" => custom_field.attributes!
            }
          }
        end
      end

    end
  end
end
