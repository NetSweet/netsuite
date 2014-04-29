module NetSuite
  module Records
    class TimeBill
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranEmp

      actions :get, :add, :search, :delete, :update

      fields :tran_date, :is_billable, :paid_externally, :rate, :override_rate, :time_type,
             :memo, :supervisor_approval, :created_date, :last_modified_date,
             :status

      field :hours, Duration

      record_refs :employee, :customer, :case_task_event, :payroll_item, :workplace, :item,
                  :department, :location, :price, :subsidiary

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
