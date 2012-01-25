module NetSuite
  module Records
    class CustomFieldList
      include Namespaces::PlatformCore

      def initialize(attributes = {})
        case attributes[:custom_field]
        when Hash
          custom_fields << CustomField.new(attributes[:custom_field])
        when Array
          attributes[:custom_field].each { |custom_field| custom_fields << CustomField.new(custom_field) }
        end
      end

      def custom_fields
        @custom_fields ||= []
      end

      def to_record
        custom_fields.map { |custom_field|
          Gyoku.xml({
            "#{record_namespace}:customField" => custom_field.to_record,
            :attributes! => {
              "#{record_namespace}:customField" => custom_field.attributes!
            }
          })
        }.join
      end

    end
  end
end
