module NetSuite
  module Records
    class ItemFulfillmentPackageUpsList
      include Support::Fields
      include Support::Records
      include Namespaces::TranSales

      fields :package_ups

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def package_ups=(packages)
        case packages
        when Hash
          self.packages << ItemFulfillmentPackageUps.new(packages)
        when Array
          packages.each { |package| self.packages << ItemFulfillmentPackageUps.new(package) }
        end
      end

      def packages
        @packages ||= []
      end

      def to_record
        { "#{record_namespace}:packageUps" => packages.map(&:to_record) }
      end
    end
  end
end
