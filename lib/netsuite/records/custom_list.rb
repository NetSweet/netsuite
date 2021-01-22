module NetSuite
  module Records
    class CustomList
      include Support::Fields
      include Support::Records
      include Support::Actions
      include Namespaces::SetupCustom

      actions :get, :update, :get_list, :add, :add_list, :delete, :search, :upsert

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/customlist.html
      fields :description, :name, :is_ordered, :script_id, :convert_to_custom_record,
             :is_inactive

      field :custom_value_list, NetSuite::Records::CustomListCustomValueList

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
