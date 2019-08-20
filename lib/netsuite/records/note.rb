module NetSuite
  module Records
    class Note
      include Support::Records
      include Support::Fields

      include Support::Actions
      include Support::RecordRefs
      include Namespaces::CommGeneral

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2016_1/schema/record/note.html

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :delete_list, :search

      fields :direction, :lastModifiedDate, :note, :noteDate, :title, :topic

      record_refs :noteType, :activity, :author, :customForm, :entity, :folder, :item, :media, :record, :recordType, :transaction

      field :custom_field_list, CustomFieldList

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

