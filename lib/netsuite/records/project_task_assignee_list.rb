module NetSuite
  module Records
    class ProjectTaskAssigneeList
      include Support::RecordRefs
      include Support::Records
      include Support::Fields
      include Namespaces::ActSched

      fields :project_task_assignee

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def project_task_assignee=(assignees)
        case assignees
          when Hash
            self.project_task_assignee << ProjectTaskAssignee.new(assignees)
          when Array
            assignees.each { |assignee| self.project_task_assignee << ProjectTaskAssignee.new(assignee) }
        end
      end

      def project_task_assignee
        @project_task_assignee ||= []
      end

      def to_record
        { "#{record_namespace}:projectTaskAssignee" => project_task_assignee.map(&:to_record) }
      end

    end
  end
end
