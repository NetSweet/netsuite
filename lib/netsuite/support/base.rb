# https://github.com/NetSweet/netsuite/pull/129#discussion_r19126261

module NetSuite
  module Support

    class Base
      include Support::Records
      include Support::Fields

      def initialize(attributes = {})
        # not all records have external/internal ID
        # we extract them here, but it's up to the subclass to create the accessors

        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
    
  end
end
