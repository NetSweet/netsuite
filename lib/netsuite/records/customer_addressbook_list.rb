module NetSuite
  module Records
    class CustomerAddressbookList
      include Namespaces::ListRel

      def initialize(attributes = {})
        case attributes[:addressbook]
        when Hash
          addressbooks << CustomerAddressbook.new(attributes[:addressbook])
        when Array
          attributes[:addressbook].each { |addressbook| addressbooks << CustomerAddressbook.new(addressbook) }
        end
      end

      def addressbooks
        @addressbooks ||= []
      end

      def to_record
        { "#{record_namespace}:addressbook" => addressbooks.map(&:to_record) }
      end

    end
  end
end
