module NetSuite
  module Records
    class CustomField
      include Support::Fields
      include Support::Records

      attr_reader :internal_id, :type

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @type        = attributes.delete(:type) || attributes.delete(:"@xsi:type")
        @type        = @type.split(':').last if @type
        self.attributes = attributes
      end

      def to_record
        hash_rec = attributes.inject({}) do |hash, (k,v)|
          kname = "#{record_namespace}:#{k.to_s.lower_camelcase}"
          v = v.to_record if v.respond_to?(:to_record)
          hash[kname] = v
          hash
        end
        hash_rec["#{record_namespace}:internalId"] = internal_id if internal_id
        hash_rec["#{record_namespace}:type"]       = type if type
        hash_rec
      end

    end
  end
end
