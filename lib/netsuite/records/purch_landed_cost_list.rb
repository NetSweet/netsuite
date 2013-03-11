module NetSuite
  module Records
    class PurchLandedCostList
      include Support::Fields
      include Namespaces::TranInvt

      fields :replace_all

      def initialize(attributes = {})
        case attributes[:landed_cost]
        when Hash
          item << LandedCost.new(attributes[:landed_cost])
        when Array
          attributes[:landed_cost].each { |inv| landed_cost << LandedCost.new(inv) }
        end
      end

      def landed_cost
        @landed_cost ||= []
      end

      def to_record
        { "#{record_namespace}:landedCost" => item.map(&:to_record) }
      end


    end
  end
end
