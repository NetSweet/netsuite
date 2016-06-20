module NetSuite
  module Records

    class Bin
      include Support::Records
      include Support::Fields
      include Support::RecordRefs
      include Support::Actions
      include Namespaces::ListAcct

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/bin.html?mode=package

      attr_reader   :internal_id
      attr_accessor :external_id

      actions :get, :add, :delete, :search, :update, :upsert

      fields :bin_number, :is_inactive, :location, :memo

      field :custom_field_list, NetSuite::Records::CustomFieldList

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end

  end
end
