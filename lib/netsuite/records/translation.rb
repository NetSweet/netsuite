module NetSuite
  module Records
    class Translation
      include Support::Fields
      include Support::Records
      include Namespaces::ListAcct

      def initialize(attributes = {})
        initialize_from_dynamic_attributes_hash(attributes)
      end
    end
  end
end
