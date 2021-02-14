module NetSuite
  module Records
    class CustomFieldList
      include Namespaces::PlatformCore

      def self.reference_id_type
        Configuration.api_version >= '2013_2' ? :script_id : :internal_id
      end

      def initialize(attributes = {})
        case attributes[:custom_field]
        when Hash
          extract_custom_field(attributes[:custom_field])
        when Array
          attributes[:custom_field].each { |custom_field| extract_custom_field(custom_field) }
        end

        @custom_fields_assoc = Hash.new
        custom_fields.each do |custom_field|
          # not all custom fields have an id
          # https://github.com/NetSweet/netsuite/issues/182

          if reference_id = custom_field.send(reference_id_type)
            @custom_fields_assoc[reference_id.to_sym] = custom_field
          end
        end
      end

      def custom_fields
        @custom_fields ||= []
      end

      def delete_custom_field(field)
        custom_fields.delete_if do |c|
          # https://github.com/NetSweet/netsuite/issues/325
          c.send(reference_id_type) &&
            c.send(reference_id_type).to_sym == field
        end

        @custom_fields_assoc.delete(field)
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
          field_name = sym.to_s[0..-2]
          delete_custom_field(field_name.to_sym)
          return create_custom_field(field_name, args.first)
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
            elsif custom_field.value.is_a?(Array)
              custom_field_value = custom_field.value.map(&:to_record)
            else
              custom_field_value = custom_field.value.to_s
            end

            base = {
              "platformCore:value" => custom_field_value,
              '@xsi:type' => custom_field.type
            }

            # TODO this is broken in > 2013_1; need to conditionally change the synax here
            # if NetSuite::Configuration.api_version < "2013_2"

            if custom_field.internal_id
              base['@internalId'] = custom_field.internal_id
            end

            if custom_field.script_id
              base['@scriptId'] = custom_field.script_id
            end

            base
          end
        }
      end

      private

        def reference_id_type
          @reference_id_type ||= self.class.reference_id_type
        end

        def extract_custom_field(custom_field_data)
          if custom_field_data.kind_of?(CustomField)
            custom_fields << custom_field_data
          else
            attrs = custom_field_data.clone
            type = (custom_field_data[:"@xsi:type"] || custom_field_data[:type])

            if type == "platformCore:SelectCustomFieldRef"
              attrs[:value] = CustomRecordRef.new(custom_field_data[:value])
            elsif type == 'platformCore:MultiSelectCustomFieldRef'
              attrs[:value] = custom_field_data[:value].map do |entry|
                CustomRecordRef.new(entry)
              end
            end

            custom_fields << CustomField.new(attrs)
          end
        end

        def create_custom_field(reference_id, field_value)
          # all custom fields need types; infer type based on class sniffing
          field_type = case
          when field_value.is_a?(Array)
            'MultiSelectCustomFieldRef'
          when field_value.is_a?(Hash),
               field_value.is_a?(NetSuite::Records::CustomRecordRef)
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
          when field_value.is_a?(Date)
            field_value.to_datetime.iso8601
          when field_value.is_a?(Time)
            field_value.iso8601
          when field_value.is_a?(Array)
            # sniff the first element of the array; if an int or string then assume internalId
            # and create record refs pointing to the given IDs

            if !field_value.empty? && (field_value.first.is_a?(String) || field_value.first.kind_of?(Integer))
              field_value.map do |v|
                NetSuite::Records::CustomRecordRef.new(internal_id: v)
              end
            else
              field_value
            end
          else
            field_value
          end

          custom_field = CustomField.new(
            reference_id_type => reference_id,
            :value => custom_field_value,
            :type  => "#{record_namespace}:#{field_type}"
          )

          custom_fields << custom_field
          @custom_fields_assoc[reference_id.to_sym] = custom_field
        end
    end
  end
end
