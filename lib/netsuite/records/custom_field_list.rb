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

      # In case you want to get only MultiSelectCustomFieldRef for example:
      #
      #   list.custom_fields_by_type "MultiSelectCustomFieldRef"
      #
      def custom_fields_by_type(type)
        custom_fields.select { |field| field.type == "platformCore:#{type}" }
      end
      
      def method_missing(sym, *args, &block)
        # read custom field if already set
        if @custom_fields_assoc.include?(sym)
          return @custom_fields_assoc[sym]
        end

        # write custom field
        if sym.to_s.end_with?('=')
          return create_custom_field(sym.to_s[0..-2], args.first)
        end

        super(sym, *args, &block)
      end

      def respond_to?(sym, include_private = false)
        return true if @custom_fields_assoc.include?(sym)
        super
      end

      def to_record
        {
          "#{record_namespace}:customField" => custom_fields.map do |custom_field|
            if custom_field.value.respond_to?(:to_record)
              custom_field_value = custom_field.value.to_record
            else
              custom_field_value = custom_field.value.to_s
            end

            {
              "platformCore:value" => custom_field_value,
              '@internalId' => custom_field.internal_id,
              '@xsi:type' => custom_field.type
            }
          end
        }
      end

      private
        def extract_custom_field(custom_field_data)
          # TODO this seems brittle, but might sufficient, watch out for this if something breaks
          if custom_field_data[:"@xsi:type"] == "platformCore:SelectCustomFieldRef"
            custom_field_data[:value] = CustomRecordRef.new(custom_field_data.delete(:value))
          end

          custom_fields << CustomField.new(custom_field_data)
        end

        def create_custom_field(internal_id, field_value)
          # all custom fields need types; infer type based on class sniffing
          field_type = case
          when field_value.is_a?(Hash)
            'SelectCustomFieldRef'
          when field_value.is_a?(DateTime),
               field_value.is_a?(Time),
               field_value.is_a?(Date)
            'DateCustomFieldRef'
          when field_value.is_a?(FalseClass),
               field_value.is_a?(TrueClass)
            'BooleanCustomFieldRef'
          else
            'StringCustomFieldRef'
          end

          # TODO seems like DateTime doesn't need the iso8601 call
          #      not sure if this is specific to my env though

          custom_field_value = case 
          when field_value.is_a?(Hash)
            CustomRecordRef.new(field_value)
          when field_value.is_a?(Time)
            field_value.iso8601
          else
            field_value
          end

          custom_field = CustomField.new(
            internal_id: internal_id,
            value: custom_field_value,
            type: "#{record_namespace}:#{field_type}"
          )

          custom_fields << custom_field
          @custom_fields_assoc[internal_id.to_sym] = custom_field
        end
    end
  end
end
