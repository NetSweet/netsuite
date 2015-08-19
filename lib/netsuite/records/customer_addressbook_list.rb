module NetSuite
  module Records
    class CustomerAddressbookList
      include Namespaces::ListRel

      def initialize(attributes = {})
        case attributes[:addressbook]
        when Hash
          addressbooks << CustomerAddressbook.new(attributes[:addressbook])
        when CustomerAddressbook
          addressbooks << attributes
        when Array
          attributes[:addressbook].each { |addressbook| addressbooks << CustomerAddressbook.new(addressbook) }
        end

        @replace_all = true
      end

      def addressbooks
        @addressbooks ||= []
      end

      def replace_all
        @replace_all
      end

      def replace_all= new_replace_all
        @replace_all = !!new_replace_all
      end

      def to_record
        { "#{record_namespace}:addressbook" => addressbooks.map(&:to_record),
          "#{record_namespace}:replaceAll" => @replace_all
        }
      end

    end
  end
end
