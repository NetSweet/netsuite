module NetSuite
  module Records
    class BillingScheduleRecurrenceList < Support::Sublist
      include Namespaces::ListAcct

      sublist :billing_schedule_recurrence, BillingScheduleRecurrence

      alias :recurrences :billing_schedule_recurrence
      alias :recurrence= :billing_schedule_recurrence=

    end
  end
end

