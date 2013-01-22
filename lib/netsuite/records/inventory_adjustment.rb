module NetSuite
  module Records
    class InventoryAdjustment
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranInvt

      actions :get, :add, :delete

      fields :tran_date, :created_date, :tran_id, :last_modified_date,
        :estimated_total_value, :memo

      field :custom_field_list, CustomFieldList
      field :inventory_list,    InventoryAdjustmentInventoryList

      record_refs :account, :customer, :department, :location, :custom_field_list

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end

    end
  end
end
