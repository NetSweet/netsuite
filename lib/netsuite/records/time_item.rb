module NetSuite
  module Records
    class TimeItem
      include Support::Fields
      include Namespaces::TranGeneral
      include Support::Records

      fields :hours, :hours_total, :id, :is_billable, :is_exempt, :is_productive, :is_utilized, :memo, :override_rate,
             :rate, :time_type, :tran_date

      record_refs :case_task_event, :class, :customer, :department, :employee, :item, :location, :payroll_item, :price,
              :temporary_local_jurisdiction, :temporary_state_jurisdiction

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
