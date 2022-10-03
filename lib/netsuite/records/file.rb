module NetSuite
  module Records
    class File
      include Support::Records
      include Support::Fields
      include Support::RecordRefs
      include Support::Actions
      include Namespaces::FileCabinet

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/file.html

      actions :get, :add, :delete, :search, :get_list, :update

      fields :content, :description, :name, :media_type_name, :file_type, :text_file_encoding, :created_date, :last_modified_date

      record_refs :folder, :klass

      read_only_fields :url

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
