module NetSuite
  module Records
    class CustomerAddressbookList < NetSuite::Records::AddressbookList
      sublist :addressbook, CustomerAddressbook

      alias :addressbooks :addressbook
    end
  end
end
