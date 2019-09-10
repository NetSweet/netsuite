module NetSuite
  module Records
    class CustomRecordRef
      include Support::Fields
      include Support::Records
      include Namespaces::PlatformCore

      attr_reader   :internal_id
      attr_accessor :external_id, :type_id

      fields :name

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          attributes = attributes_or_record.clone
          attributes.delete(:"@xmlns:platform_core")
          @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
          @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
          @type_id     = attributes.delete(:type_id) || attributes.delete(:@type_id)
          @type_id     = @type_id.to_s if @type_id
          initialize_from_attributes_hash(attributes)
        else
          record = attributes_or_record
          @internal_id = record.internal_id if record.respond_to?(:internal_id)
          @external_id = record.external_id if record.respond_to?(:external_id)
          @type_id     = record.class.type_id if record.class.respond_to?(:type_id) && record.class.type_id
          @type_id     = @type_id.to_s if @type_id
        end
      end

      def method_missing(m, *args, &block)
        if attributes.keys.map(&:to_sym).include?(m.to_sym)
          attributes[m.to_sym]
        else
          super
        end
      end

      def to_record
        rec = super
        rec[:@internalId] = @internal_id if @internal_id
        rec[:@externalId] = @external_id if @external_id
        rec[:@typeId] = @type_id if @type_id
        rec
      end

    end
  end
end
