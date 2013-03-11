module NetSuite
  module Records
    class ItemReceiptItemList
      include Support::Fields
      include Namespaces::TranPurch

      fields :replace_all

      def initialize(attributes = {})
        case attributes[:item]
        when Hash
          item << ItemReceiptItem.new(attributes[:item])
        when Array
          attributes[:item].each { |inv| item << ItemReceiptItem.new(inv) }
        end
      end

      def item
        @item ||= []
      end

      def to_record
        { "#{record_namespace}:item" => item.map(&:to_record) }
      end


    end
  end
end
