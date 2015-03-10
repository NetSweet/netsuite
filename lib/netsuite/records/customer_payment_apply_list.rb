module NetSuite
  module Records
    class CustomerPaymentApplyList
      include Namespaces::TranCust

      def initialize(attributes = {})
        case attributes[:apply]
        when Hash
          applies << CustomerPaymentApply.new(attributes[:apply])
        when Array
          attributes[:apply].each { |apply| applies << CustomerPaymentApply.new(apply) }
        end
      end

      def applies
        @applies ||= []
      end

      def to_record
        [{ 
          "#{record_namespace}:apply" => applies.map do |apply|
            apply.to_record 
          end
        }]
      end

    end
  end
end
