module NetSuite
  module Records
    class AssemblyBuild
      include Support::Fields
      include Support::RecordRefs
      include Support::Actions
      include Support::Records
      include Namespaces::TranInvt

      actions :get, :add, :initialize, :delete, :update, :upsert, :upsert_list,
        :search

      fields :bin_numbers, :buildable, :created_date, :expiration_date,
        :last_modified_date, :memo, :quantity, :serial_numbers,
        :tran_date, :tran_id

	  read_only_fields :total

      record_refs :klass, :created_from, :item, :custom_form,
        :department, :job, :location, :posting_period, :revision,
        :subsidiary, :units

      field :component_list,        AssemblyComponentList
      field :custom_field_list,     CustomFieldList
      field :inventory_detail,      InventoryDetail


      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end

