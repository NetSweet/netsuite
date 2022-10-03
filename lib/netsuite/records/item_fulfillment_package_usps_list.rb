module NetSuite
  module Records
    class ItemFulfillmentPackageUspsList
      include Support::Fields
      include Support::Records
      include Namespaces::TranSales

      fields :package_usps

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def package_usps=(packages)
        case packages
        when Hash
          self.packages << ItemFulfillmentPackageUsps.new(packages)
        when Array
          packages.each { |package| self.packages << ItemFulfillmentPackageUsps.new(package) }
        end
      end

      def packages
        @packages ||= []
      end

      def to_record
        { "#{record_namespace}:packageUsps" => packages.map(&:to_record) }
      end
    end
  end
end
