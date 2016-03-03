module NetSuite
  module Records
    class JobResources
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::ListRel

      fields :email

      record_refs :job_resource, :role

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
