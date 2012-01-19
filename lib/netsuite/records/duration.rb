module NetSuite
  module Records
    class Duration
      include Support::Fields
      include Support::Records

      fields :time_span, :unit

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
