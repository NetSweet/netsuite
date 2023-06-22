module NetSuite
  module Records
    class PayrollItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListEmp

      actions :add, :delete, :delete_list, :get, :get_list, :search, :update, :upsert, :upsert_list

      fields :employee_paid, :inactive, :name

      field :custom_field_list, CustomFieldList

      record_refs :expense_account, :item_type, :liability_account, :subsidiary, :vendor

      attr_reader :internal_id
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
