module NetSuite
  module Records
    class Location
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :add, :delete, :get, :get_list, :get_select_value, :search,
        :update, :upsert

      fields :include_children, :is_inactive

      field :custom_field_list, CustomFieldList
      # field :class_translation_list
      field :subsidiary_list, RecordRefList

      record_refs :logo, :parent

      # API >= 2014_2
      field :main_address, Address
      field :return_address, Address

      # API < 2014_2
      fields :addr1, :addr2, :addr3, :addr_phone, :addr_text, :addressee, :attention, :city, :country,
        :make_inventory_available, :make_inventory_available_store, :name, :override, :state, :tran_prefix, :zip

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
