module NetSuite
  module Records
    class RecordRef
      include Support::Fields
      include Support::Records
      include Namespaces::PlatformCore

      attr_reader :internal_id, :type

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          attributes_or_record.delete(:"@xmlns:platform_core")
          @internal_id = attributes_or_record.delete(:internal_id) || attributes_or_record.delete(:@internal_id)
          @type        = attributes_or_record.delete(:type) || attributes_or_record.delete(:@type)
          @attributes  = attributes_or_record
        else
          @internal_id = attributes_or_record.internal_id if attributes_or_record.respond_to?(:internal_id)
          @type        = attributes_or_record.class.to_s.split('::').last.lower_camelcase
        end
      end

      def method_missing(m, *args, &block)
        if attributes.keys.map(&:to_sym).include?(m.to_sym)
          attributes[m.to_sym]
        else
          super
        end
      end

    end
  end
end
