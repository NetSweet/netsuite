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
        
        @custom_fields_assoc = Hash.new
        @custom_fields.each { |custom_field| @custom_fields_assoc[custom_field.internal_id.to_sym] = custom_field }
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
