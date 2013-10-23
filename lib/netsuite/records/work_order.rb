module NetSuite
  module Records
    class WorkOrder
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranInvt

      actions :get, :add, :delete, :update, :search

      fields :tran_id, :tran_date, :memo, :expand_assembly,
        :start_date, :end_date, :quantity, :klass

      field :custom_field_list, CustomFieldList
      field :assembly_item, AssemblyItem

      record_refs :location, :department

      attr_accessor :internal_id
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
