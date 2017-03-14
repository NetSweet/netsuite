module NetSuite
  module Records
    class MemberList < Support::Sublist
      include Namespaces::ListAcct

      fields :replace_all

      sublist :item_member, ItemMember

    end
  end
end
