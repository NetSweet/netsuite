module NetSuite
  module Records
    class ItemFulfillmentPackageList
      include Support::Fields
      include Support::Records
      include Namespaces::TranSales

      fields :package

      def initialize(attributes = {})
        if attributes.keys != [:package] && attributes.first

          transformed_attrs = {}
          attributes.first.last.each do |k, v|
            transformed_attrs.merge!(k[0..-5].to_sym => v)
          end

          attributes = { package: transformed_attrs }
        end

        initialize_from_attributes_hash(attributes)
      end

      def package=(packages)
        case packages
        when Hash
          self.packages << ItemFulfillmentPackage.new(packages)
        when Array
          packages.each { |package| self.packages << ItemFulfillmentPackage.new(package) }
        end
      end

      def packages
        @packages ||= []
      end

      def to_record
        { "#{record_namespace}:package" => items.map(&:to_record) }
      end
    end
  end
end
