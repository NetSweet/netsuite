# https://github.com/NetSweet/netsuite/pull/129#discussion_r19126261

module NetSuite
  module Support
    class Base

      include Support::Fields

      attr_reader   :internal_id
      attr_accessor :external_id

      field :custom_field_list, NetSuite::Records::CustomFieldList

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
    
  end
end
