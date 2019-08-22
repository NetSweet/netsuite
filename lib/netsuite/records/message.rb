module NetSuite
  module Records
    class Message
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::CommGeneral

      actions :get, :add, :delete, :search
      
      fields :bcc, :cc, :compress_attachments, :date_time, :emailed, :incoming,
             :message, :record_name, :record_type_name, :subject

      read_only_fields :last_modified_date, :message_date

      record_refs :activity, :author, :recipient, :transaction

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes_or_record = {})
        @internal_id = attributes_or_record.delete(:internal_id) || attributes_or_record.delete(:@internal_id)
        @external_id = attributes_or_record.delete(:external_id) || attributes_or_record.delete(:@external_id)
        initialize_from_attributes_hash(attributes_or_record)
      end

    end
  end
end
