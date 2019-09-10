module NetSuite
  module Records
    class ContactAddressbookList < Support::Sublist
      include Namespaces::ListRel

      sublist :addressbook, ContactAddressbook

      alias :addressbooks :addressbook
    end
  end
end
