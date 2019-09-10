module NetSuite
  module Records
    class BinTransfer
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranInvt

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :created_date, :last_modified_date, :memo, :subsidiary, :tran_date, :tran_id

      record_refs :location

      field :custom_field_list, CustomFieldList
      field :inventory_list, BinTransferInventoryList

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

      def self.search_class_namespace
        'tranSales'
      end

    end
  end
end
