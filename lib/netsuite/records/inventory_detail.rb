module NetSuite
  module Records
    class InventoryDetail
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::PlatformCommon

      field :inventory_assignment_list, InventoryAssignmentList

      record_refs :custom_form

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
