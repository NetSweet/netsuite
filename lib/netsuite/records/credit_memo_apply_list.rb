module NetSuite
  module Records
    class CreditMemoApplyList
      include Namespaces::TranCust

      def initialize(attributes = {})
        case attributes[:apply]
        when Hash
          applies << CreditMemoApply.new(attributes[:apply])
        when Array
          attributes[:apply].each { |apply| applies << CreditMemoApply.new(apply) }
        end
      end

      def applies
        @applies ||= []
      end

      def to_record
        { "#{record_namespace}:apply" => applies.map(&:to_record) }
      end
    end
  end
end
