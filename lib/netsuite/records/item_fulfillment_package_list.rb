module NetSuite
  module Records
    class ItemFulfillmentPackageList < Support::Sublist
      include Namespaces::TranSales

      sublist :package, ItemFulfillmentPackage

      def initialize(attributes = {})
        if attributes.keys != [:package] && attributes.first

          transformed_attrs = {}
          object = attributes.first.last

          case object
          when Hash
            object.each do |k, v|
              transformed_attrs.merge!(k[0..-5].to_sym => v)
            end
          when Array
            object.each do |hash|
              hash.each do |k, v|
                transformed_attrs.merge!(k[0..-5].to_sym => v)
              end
            end
          end

          attributes = { package: transformed_attrs }
        end

        initialize_from_attributes_hash(attributes)
      end

      alias :packages :package

    end
  end
end
