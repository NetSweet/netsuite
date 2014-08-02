module NetSuite
  module Records
    class BillingScheduleMilestone
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::ListAcct

      fields :comments, :milestone_actual_completion_date, :milestone_amount, 
        :milestone_completed, :milestone_date, :milestone_id

      record_refs :milestone_term, :project_task

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          initialize_from_attributes_hash(attributes_or_record)
        when self.class
          initialize_from_record(attributes_or_record)
        end
      end

      def initialize_from_record(record)
        self.attributes = record.send(:attributes)
      end
    end
  end
end
