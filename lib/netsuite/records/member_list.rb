module NetSuite
  module Records
    class MemberList < Support::Sublist
      include Namespaces::ListAcct

      sublist :item_member, ItemMember

    end
  end
end
