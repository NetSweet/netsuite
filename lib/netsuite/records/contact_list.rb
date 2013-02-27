module NetSuite
  module Records
    class ContactList
      include Namespaces::ActSched

      def initialize(attributes = {})
        # TODO look into the possibility of just pulling out the internal_id from the passed record data
        # I believe this is all NS needs, and I've had trouble passing an entire record into the list
        
        case attributes[:contact]
        when Hash
          contacts << Contact.new(attributes[:contact])
        when Array
          attributes[:contact].each { |contact| contacts << Contact.new(contact) }
        end
      end

      def <<(contact)
        @contacts << contact
      end

      def contacts
        @contacts ||= []
      end

      def to_record
        contacts.map do |contact|
          { "#{record_namespace}:contact" => contact.to_record }
        end
      end

    end
  end
end
