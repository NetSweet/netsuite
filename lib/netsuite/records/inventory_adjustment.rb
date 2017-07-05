module NetSuite
  module Records
    class InventoryAdjustment
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranInvt

      actions :get, :add, :delete, :search, :update, :upsert, :upsert_list

      fields :created_date, :estimated_total_value, :last_modified_date, :tran_date, :tran_id, :memo

      field :inventory_list, InventoryAdjustmentInventoryList
      field :custom_field_list, CustomFieldList
      
      record_refs :account, :adj_location, :customer, :posting_period, :location, :department,
        :subsidiary, :custom_form, :klass

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
