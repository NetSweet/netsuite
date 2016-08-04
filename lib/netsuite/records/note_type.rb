module NetSuite
  module Records
    class NoteType
      include Support::Records
      include Support::Fields
      include Support::Actions
      include Namespaces::CommGeneral

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/note.html

      actions :get, :search

      fields :name, :description, :is_inactive

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

