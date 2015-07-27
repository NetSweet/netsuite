module NetSuite
  module Records
    class InventoryAdjustment
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranInvt

      actions :get, :get_list, :add, :initialize, :update, :delete, :search, :upsert

      fields :created_date, :estimated_total_value, :last_modified_date, :memo, :tran_date, :tran_id
      
      field :custom_field_list,        CustomFieldList
      field :inventory_list,           InventoryAdjustmentInventoryList

      record_refs :account, :adjLocation, :customer, :custom_form, :department, :klass, :location, :posting_period, 
        :subsidiary

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.search_class_name
        "Transaction"
      end            
    end
  end
end