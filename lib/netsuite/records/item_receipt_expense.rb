module NetSuite
  module Records
    class ItemReceiptExpense
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranPurch

      actions :get, :add, :delete, :update


      attr_reader   :internal_id
      attr_accessor :external_id

      fields :mark_received, :order_line, :line, :account, :memo,
        :amount

      field :custom_field_list, CustomFieldList


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
