module NetSuite
  module Records
    class AddressbookList < Support::Sublist
      include Namespaces::ListRel
      include Support::Actions

      actions :get

      sublist :addressbook, Addressbook

      alias :addressbooks :addressbook
    end
  end
end
