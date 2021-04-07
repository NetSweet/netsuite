module NetSuite
    module Records
      class EmployeeAddressbookList < Support::Sublist
        include Namespaces::ListEmp
  
        sublist :addressbook, EmployeeAddressbook
  
        alias :addressbooks :addressbook
      end
    end
  end
  