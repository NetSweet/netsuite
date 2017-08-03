module NetSuite
  module Records
    class ContactAddressbookList < NetSuite::Records::AddressbookList
      sublist :addressbook, ContactAddressbook

      alias :addressbooks :addressbook
    end
  end
end
