# http://www.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2016_2/schema/record/customerstatus.html

module NetSuite
  module Records

    class CustomerStatus
      include Support::Records
      include Support::Fields
      include Support::RecordRefs
      include Support::Actions
      include Namespaces::ListRel

      actions :get, :add, :delete, :search, :update, :upsert

      fields :description, :include_in_lead_reports, :is_inactive, :name,
             :probability, :stage

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end

  end
end
