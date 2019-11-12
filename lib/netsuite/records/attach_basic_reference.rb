module NetSuite
  module Records
    class AttachBasicReference
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::PlatformCore

      actions :attach

      record_refs :attach_to, :attached_record

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
