module NetSuite
  module Records
    class ContactRole
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :initialize, :search

      fields :name, :is_inactive, :description, :created_date

      attr_reader :internal_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
