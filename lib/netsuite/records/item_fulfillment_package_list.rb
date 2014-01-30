module NetSuite
  module Records
    class ItemFulfillmentPackageList
      include Support::Fields
      include Support::Records
      include Namespaces::TranSales

      fields :item

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def item=(items)
        case items
        when Hash
          self.items << ItemFulfillmentPackage.new(items)
        when Array
          items.each { |item| self.items << ItemFulfillmentPackage.new(item) }
        end
      end

      def items
        @items ||= []
      end

      def to_record
        { "#{record_namespace}:package" => items.map(&:to_record) }
      end
    end
  end
end
