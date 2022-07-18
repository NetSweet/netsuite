module NetSuite
  module Records
    class Subscription
      include Support::Fields
      include Support::Records
      include Support::RecordRefs
      include Namespaces::ListRel

      fields :subscribed, :last_modified_date
      record_refs :subscription

      def initialize(attributes_or_record = {})
        initialize_from_attributes_hash(attributes_or_record)
      end

    end
  end
end
