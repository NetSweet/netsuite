module NetSuite
  module Records
    class CustomerAddressbookList < Support::Sublist
      include Namespaces::ListRel
      
      actions :get

      sublist :addressbook, CustomerAddressbook

      alias :addressbooks :addressbook
    end
  end
end
