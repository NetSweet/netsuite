module NetSuite
  module Records
    class ItemMemberList < Support::Sublist
      include Namespaces::ListAcct

      sublist :item_member, ItemMember

      alias :item_members :item_member

    end
  end
end
