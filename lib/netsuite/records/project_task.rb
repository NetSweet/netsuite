module NetSuite
  module Records
    class ProjectTask
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ActSched

      actions :get, :get_list, :add, :delete, :search, :update, :upsert

      fields :actual_work, :end_date, :end_date_baseline, :estimated_work, :estimated_work_baseline, :finish_by_date,
             :is_milestone, :is_on_critical_path, :late_end, :late_start, :message, :non_billable_task, :percent_time_complete,
             :remaining_work, :slack_minutes, :start_date, :start_date_baseline, :title, :status, :constraint_type

      field :assignee_list,     ProjectTaskAssigneeList
      field :custom_field_list, CustomFieldList
      field :time_item_list,    ProjectTaskTimeItemList

      record_refs :company, :contact, :custom_form, :event_id, :order, :owner, :parent, :priority

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
