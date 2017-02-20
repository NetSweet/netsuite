module NetSuite
  module Records
    class VendorReturnAuthorization
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranPurch

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :billing_address, :created_date, :memo, :tran_date, :tran_id

      record_refs :bill_address_list, :department, :entity, :location

      field :custom_field_list,   CustomFieldList
      field :item_list,           VendorReturnAuthorizationItemList

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
