module NetSuite
  module Records
    class CostCategory
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :add, :delete, :delete_list, :get, :get_all, :get_list, :get_select_value, :search, :update, :update_list, :upsert, :upsert_list
      # TODO: Add add_list when supported by gem

      fields :is_inactive, :item_cost_type, :name

      record_refs :account

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
