module NetSuite
  module Records
    class RecordRef

      attr_reader :internal_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
      end

    end
  end
end
