module NetSuite
  module Records
    class UnitsTypeUomList
      include Support::Fields
      include Namespaces::ListAcct

      fields :uom

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def uom=(items)
        case items
        when Hash
          self.uom << UnitsTypeUom.new(items)
        when Array
          items.each { |item| self.uom << UnitsTypeUom.new(item) }
        end
      end

      def uom
        @uom ||= []
      end

      def to_record
        { "#{record_namespace}:uom" => uom.map(&:to_record) }
      end
    end
  end
end


