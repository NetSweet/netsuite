module NetSuite
  module Records
    class MemberList
      include Support::Fields
      include Support::Records
      include Namespaces::ListAcct

      fields :replace_all, :item_member

      def initialize(attrs = {})
        initialize_from_attributes_hash(attrs)
      end

      def item_member=(items)
        case items
        when Hash
          self.item_member << ItemMember.new(items)
        when Array
          items.each { |ref| self.item_member << ItemMember.new(ref) }
        end
      end

      def item_member
        @item_member ||= []
      end

      def to_record
        { "#{record_namespace}:itemMember" => item_member.map(&:to_record) }
      end
    end
  end
end
