module NetSuite
  module Records
    class Department
      include Support::Fields
      include Support::RecordRefs
      include Support::Actions

      actions :get, :add, :delete, :upsert

      fields :name, :is_inactive
      
      record_refs :parent

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
