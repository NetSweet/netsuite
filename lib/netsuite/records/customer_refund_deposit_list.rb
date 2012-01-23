module NetSuite
  module Records
    class CustomerRefundDepositList
      include Support::Records
      include Namespaces::TranCust

      def initialize(attributes = {})
        case attributes[:customer_refund_deposit]
        when Hash
          deposits << CustomerRefundDeposit.new(attributes[:customer_refund_deposit])
        when Array
          attributes[:customer_refund_deposit].each { |deposit| deposits << CustomerRefundDeposit.new(deposit) }
        end
      end

      def deposits
        @deposits ||= []
      end

      def to_record
        deposits.map do |deposit|
          { "#{record_namespace}:customerRefundDeposit" => deposit.to_record }
        end
      end

    end
  end
end
