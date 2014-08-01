module NetSuite
  module Records
    class BillingScheduleRecurrenceList
      include Support::Fields
      include Namespaces::ListAcct

      fields :billing_schedule_recurrence

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def recurrence=(recurrences)
        case recurrences
        when Hash
          self.recurrences << BillingScheduleRecurrence.new(recurrences)
        when Array
          recurrences.each { |recurrence| self.recurrences << BillingScheduleRecurrence.new(recurrence) }
        end
      end

      def recurrences
        @recurrences ||= []
      end

      def to_record
        { "#{record_namespace}:billingScheduleRecurrence" => recurrences.map(&:to_record) }
      end

    end
  end
end

