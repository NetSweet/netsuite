module NetSuite
  module Records
    class CustomerPartner
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::ListRel

      fields :is_primary, :contribution

      record_refs :partner

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when Hash
          initialize_from_attributes_hash(attributes_or_record)
        when self.class
          initialize_from_record(attributes_or_record)
        end
      end

    end
  end
end
