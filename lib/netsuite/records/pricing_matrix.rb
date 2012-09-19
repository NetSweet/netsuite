module NetSuite
  module Records
    class PricingMatrix
      include Namespaces::PlatformCore

      def initialize(attributes = {})
        attributes[:pricing].each do |pricing|
          prices << RecordRef.new(pricing)
        end if attributes[:pricing]
      end

      def prices
        @prices ||= []
      end

      def to_record
        { "#{record_namespace}:item" => prices.map(&:to_record) }
      end
    end
  end
end
