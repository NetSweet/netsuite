module NetSuite
  module Records
    class AssemblyUnbuild
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
	  include Support::Fields
      include Namespaces::TranInvt

      actions :get, :add, :initialize, :delete, :update, :upsert, :upsert_list,
        :search

      fields :bin_numbers, :built, :created_date, :expiration_date,
        :last_modified_date, :memo, :quantity, :serial_numbers,
        :tran_date, :tran_id

	  read_only_fields :total

      field :component_list,        AssemblyComponentList
      field :inventory_detail,      InventoryDetail

      record_refs :klass, :created_from, :item, :custom_form,
        :department, :job, :location, :posting_period, :revision,
        :subsidiary, :units

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
