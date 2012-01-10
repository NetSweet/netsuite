module NetSuite
  module Records
    class RecordRef
      include Support::Attributes
      include Support::Records
      include Namespaces::PlatformCore

      attr_reader :internal_id

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          attributes_or_record.delete(:"@xmlns:platform_core")
          @internal_id = attributes_or_record.delete(:internal_id) || attributes_or_record.delete(:@internal_id)
          @attributes  = attributes_or_record
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
