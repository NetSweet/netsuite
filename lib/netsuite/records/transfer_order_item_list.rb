module NetSuite
  module Records
    class TransferOrderItemList
      include Support::Fields
      include Namespaces::TranInvt

      def initialize(attributes = {})
        case attributes[:item]
        when Hash
          item << TransferOrderItem.new(attributes[:item])
        when Array
          attributes[:item].each { |inv| item << TransferOrderItem.new(inv) }
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
