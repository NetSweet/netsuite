module NetSuite
  module Records
    class EmployeeAddressbookList < Support::Sublist
      include Namespaces::ListEmp
      include Support::Actions

      actions :get

      sublist :addressbook, EmployeeAddressbook

      alias :addressbooks :addressbook
    end
  end
end
