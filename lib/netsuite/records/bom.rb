module NetSuite
  module Records
    class Bom
      include Support::Actions
      include Support::Fields
      include Namespaces::ListAcct

      actions :get, :get_list

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
