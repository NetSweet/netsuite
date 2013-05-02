module NetSuite
  module Records
    class InventoryItemLocationsList
      include Support::Fields
      include Namespaces::ListAcct

      def initialize(attributes = {})
        att_class = attributes[:locations].class
        case att_class.to_s
        when "Hash"
          locations << InventoryItemLocations.new(attributes[:locations])
        when "Array"
          attributes[:locations].each { |inv|
            locations << InventoryItemLocations.new(inv)
          }
        end
      end

      def locations
        @locations ||= []
      end

      def to_record
        { "#{record_namespace}:locations" => locations.map(&:to_record) }
      end

    end
  end
end
