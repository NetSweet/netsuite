module NetSuite
  module Records
    class WorkOrder
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranInvt

      actions :get, :add, :initialize, :delete, :update, :upsert, :upsert_list,
        :search

      fields :buildable, :built, :created_date, :end_date, :expanded_assembly,
        :firmed, :is_wip, :last_modified_date, :memo, :order_status,
        :partners_list, :quantity, :sales_team_list, :source_transaction_id,
        :source_transaction_line, :special_order, :start_date, :status,
        :tran_date, :tran_id

      field :custom_field_list, CustomFieldList
      field :options,           CustomFieldList
      field :item_list,         WorkOrderItemList

      record_refs :assembly_item, :created_from, :custom_form,
        :department, :entity, :job, :location, :manufacturing_routing,
        :revision, :subsidiary, :units

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.search_class_name
        "Transaction"
      end

      def self.search_class_namespace
        'tranSales'
      end
    end
  end
end
