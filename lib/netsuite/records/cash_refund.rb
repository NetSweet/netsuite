module NetSuite
  module Records
    class CashRefund
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranCust

      actions :add, :get, :delete

      fields :tran_date, :to_be_emailed

      field :item_list, CashRefundItemList
      field :custom_field_list, CustomFieldList

      record_refs :entity, :custom_form, :payment_method, :created_from

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
