module NetSuite
  module Records
    class CustomFieldList
      include Namespaces::PlatformCore

      def initialize(attributes = {})
        case attributes[:custom_field]
        when Hash
          extract_custom_field(attributes[:custom_field])
        when Array
          attributes[:custom_field].each { |custom_field| extract_custom_field(custom_field) }
        end
        
        @custom_fields_assoc = Hash.new
        custom_fields.each { |custom_field| @custom_fields_assoc[custom_field.internal_id.to_sym] = custom_field }
      end

      def custom_fields
        @custom_fields ||= []
      end
      
      def method_missing(sym, *args, &block)
        return @custom_fields_assoc[sym] if @custom_fields_assoc.include? sym
        super(sym, *args, &block)
      end

      def respond_to?(sym, include_private = false)
        return true if @custom_fields_assoc.include? sym
        super
      end

      def to_record
        custom_fields.map do |custom_field|
          {
            "#{record_namespace}:customField" => {
              :content! => custom_field.value.to_s,
              '@internalId' => custom_field.internal_id,
              '@xsi:type' => custom_field.type
            }
          }
        end
      end

      private
        def extract_custom_field(custom_field_data)
          # TODO this needs to be cleaned up & tested; very messy
          if custom_field_data[:"@xsi:type"] == "platformCore:SelectCustomFieldRef"
            custom_field_data[:value] = CustomRecordRef.new(custom_field_data.delete(:value))
          end

          custom_fields << CustomField.new(custom_field_data)
        end
    end
  end
end
