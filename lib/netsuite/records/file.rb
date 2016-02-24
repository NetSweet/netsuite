module NetSuite
  module Records
    class File < NetSuite::Support::Base
      include Support::RecordRefs
      include Support::Actions
      include Namespaces::FileCabinet

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/file.html

      actions :get, :add, :delete, :search, :get_list

      fields :content, :description, :name, :media_type_name, :file_type, :text_file_encoding

      record_refs :folder, :klass

      read_only_fields :url

      attr_reader   :internal_id
      attr_accessor :external_id
    end
  end
end

