module NetSuite
  module Records
    class BillingScheduleMilestoneList < Support::Sublist
      include Namespaces::ListAcct

      sublist :billing_schedule_milestone, BillingScheduleMilestone

      alias :milestones :billing_schedule_milestone
      alias :milestone= :billing_schedule_milestone=

    end
  end
end

