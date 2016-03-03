module NetSuite
  module Records
    class ProjectTaskAssignee
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::ActSched

      fields :cost, :estimated_work, :price, :unit_cost, :unit_price, :units

      record_refs :resource, :service_item

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
