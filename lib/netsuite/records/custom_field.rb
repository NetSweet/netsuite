module NetSuite
  module Records
    class CustomField
      include Support::Fields
      include Support::Records

      attr_reader :internal_id, :type

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @type        = attributes.delete(:type) || attributes.delete(:"@xsi:type")
        self.attributes = attributes
      end

      def to_record
        unless type == "platformCore:SelectCustomFieldRef"
          hash_rec = attributes.inject({}) do |hash, (k,v)|
            kname = "#{record_namespace}:#{k.to_s.lower_camelcase}"
            to_attributes!(hash, kname, v)
            v = v.to_record if v.respond_to?(:to_record)
            hash[kname] = v
            hash
          end
        else
          hash_rec = {:value => {:internal_id => attributes[:value][:@internal_id] || attributes[:value][:internal_id] }}
        end
        hash_rec
      end

      def attributes!
        attr_hash = {}
        attr_hash['internalId'] = internal_id if internal_id
        attr_hash['xsi:type']   = type        if type
        attr_hash
      end

    end
  end
end
