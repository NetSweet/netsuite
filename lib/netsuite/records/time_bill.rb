module NetSuite
  module Records
    class TimeBill
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranEmp

      actions :get, :get_list, :add, :delete, :search, :update, :upsert

      fields :created_date, :is_billable, :last_modified_date, :memo, :override_rate, :paid_externally, :rate, :status,
             :supervisor_approval, :tran_date, :time_type

      field :custom_field_list,   CustomFieldList
      field :hours,               Duration

      record_refs :employee, :customer, :case_task_event, :payroll_item, :workplace, :item, :department, :location, :price,
                  :subsidiary, :temporary_local_jurisdiction, :temporary_state_jurisdiction

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
