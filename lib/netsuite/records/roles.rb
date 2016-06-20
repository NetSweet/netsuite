module NetSuite
  module Records
    class Roles
      include Support::Records
      include Support::Fields
      include Support::RecordRefs
      include Namespaces::ListEmp

      record_refs :selected_role

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
