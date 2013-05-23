module NetSuite
  module Records
    class SalesOrderItemList
      include Support::Fields
      include Support::Records
      include Namespaces::TranSales

      fields :replace_all

      def initialize(attributes = {})
        case attributes[:item]
        when Hash
          item << ItemFulfillmentItem.new(attributes[:item])
        when Array
          attributes[:item].each { |inv| item << ItemFulfillmentItem.new(inv) }
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
