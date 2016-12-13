module NetSuite
  module Records
    class ContactList
      include Namespaces::ActSched

      def initialize(attributes = {})
        # - the contact list on the NS GUI doesn't show the assigned contact which shows up in the XML
        # - you can't add an arbitary number of contacts through the NS GUI

        # TODO the contact list doesn't really work because of the strange XML below (2 assigned companies, one contact)
        
        # <actSched:contactList>
        #   <actSched:contact>
        #     <actSched:company xmlns:platformCore="urn:core_2012_1.platform.webservices.netsuite.com" internalId="12345">
        #       <platformCore:name>10001 Another Customer</platformCore:name>
        #     </actSched:company>
        #   </actSched:contact>
        #   <actSched:contact>
        #     <actSched:company xmlns:platformCore="urn:core_2012_1.platform.webservices.netsuite.com" internalId="12346">
        #       <platformCore:name>31500 A Customer</platformCore:name>
        #     </actSched:company>
        #     <actSched:contact xmlns:platformCore="urn:core_2012_1.platform.webservices.netsuite.com" internalId="12347">
        #       <platformCore:name>A Person</platformCore:name>
        #     </actSched:contact>
        #   </actSched:contact>
        # </actSched:contactList>

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
        { "#{record_namespace}:contact" => contacts.map(&:to_record) }
      end
    end
  end
end
