module NetSuite
  module Records
    class AssemblyBuild
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranInvt

      actions :get, :add, :update, :search, :initialize

      fields :created_date, :last_modified_date, :tran_date,
        :klass, :custom_form, :quantity, :tran_id, :total

      field :custom_field_list, CustomFieldList
      field :item, AssemblyItem

      record_refs :department, :created_from, :location
        #,:posting_period, :units, :custom_form

      attr_accessor :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        attributes.delete(:class)
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
