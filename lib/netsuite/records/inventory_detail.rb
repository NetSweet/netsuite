module NetSuite
  module Records
    class InventoryDetail
      include Support::RecordRefs
      include Support::Records
      include Support::Fields
      include Namespaces::PlatformCommon

      record_ref :custom_form

      field :inventory_assignment_list, InventoryAssignmentList

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
