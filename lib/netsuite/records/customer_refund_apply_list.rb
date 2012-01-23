module NetSuite
  module Records
    class CustomerRefundApplyList
      include Namespaces::TranCust

      def initialize(attributes = {})
        case attributes[:apply]
        when Hash
          applies << CustomerRefundApply.new(attributes[:apply])
        when Array
          attributes[:apply].each { |apply| applies << CustomerRefundApply.new(apply) }
        end
      end

      def applies
        @applies ||= []
      end

      def to_record
        applies.map do |apply|
          { "#{record_namespace}:apply" => apply.to_record }
        end
      end

    end
  end
end
