module NetSuite
  module Records
    class ItemFulfillmentPackageList
      include Support::Fields
      include Namespaces::TranSales

      def initialize(attributes = {})
        att_class = attributes[:package].class
        case att_class.to_s
        when "Hash"
          package << ItemFulfillmentPackage.new(attributes[:package])
        when "Array"
          attributes[:package].each { |inv|
            package << ItemFulfillmentPackage.new(inv)
          }
        end
      end

      def package
        @package ||= []
      end

      def to_record
        { "#{record_namespace}:package" => package.map(&:to_record) }
      end

    end
  end
end
