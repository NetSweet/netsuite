module NetSuite
  module Records
    class BillingScheduleMilestoneList
      include Support::Fields
      include Namespaces::ListAcct

      fields :billing_schedule_milestone

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def milestone=(milestones)
        case milestones
        when Hash
          self.milestones << BillingScheduleMilestone.new(milestones)
        when Array
          milestones.each { |milestone| self.milestones << BillingScheduleMilestone.new(milestone) }
        end
      end

      def milestones
        @milestones ||= []
      end

      def to_record
        { "#{record_namespace}:billingScheduleMilestone" => milestones.map(&:to_record) }
      end

    end
  end
end

