module NetSuite
  module Records
    class CustomerCategory
      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2015_2/schema/record/customercategory.html

      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_deleted, :get_list, :get_all, :add, :update, :delete, :search

      fields :name, :is_inactive

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
