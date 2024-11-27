module NetSuite
  module Records
    class CustomerSubsidiaryRelationship
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListRel

      actions :get, :get_list, :add, :search

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2024_1/schema/record/customersubsidiaryrelationship.html

      fields :is_primary_sub, :is_inactive

      field :custom_field_list,   CustomFieldList

      record_refs :entity, :primary_currency, :subsidiary

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)

        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
