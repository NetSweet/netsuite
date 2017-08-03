module NetSuite
  module Records
    class EmployeeAddressbookList < NetSuite::Records::AddressbookList
      sublist :addressbook, EmployeeAddressbook

      alias :addressbooks :addressbook
    end
  end
end
