module NetSuite
  module Records
    class JobResourcesList
      include Support::RecordRefs
      include Support::Records
      include Support::Fields
      include Namespaces::ListRel

      fields :job_resources

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def job_resources=(resources)
        case resources
        when Hash
          self.job_resources << JobResources.new(resources)
        when Array
          resources.each { |resource| self.job_resources << JobResources.new(resource) }
        end
      end

      def job_resources
        @job_resources ||= []
      end

      def to_record
        { "#{record_namespace}:jobResources" => job_resources.map(&:to_record) }
      end

    end
  end
end
