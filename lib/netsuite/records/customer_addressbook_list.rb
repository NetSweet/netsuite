module NetSuite
  module Records
    class CustomerAddressbookList < Support::Sublist
      include Namespaces::ListRel
      include Support::Actions
      
      actions :get

      sublist :addressbook, CustomerAddressbook

      alias :addressbooks :addressbook
    end
  end
end
