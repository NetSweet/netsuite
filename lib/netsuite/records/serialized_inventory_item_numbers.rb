module NetSuite
  module Records
    class SerializedInventoryItemNumbers
      include Support::Fields
      include Support::Records
      include Namespaces::ListAcct

      fields :serial_number

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
