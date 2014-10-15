module NetSuite
  module Records
    class CustomerRefundDepositList
      include Support::Fields
      include Support::Records
      include Namespaces::TranCust
 
      fields :replace_all
 
      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
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
        super.merge({ "#{record_namespace}:customerRefundDeposit" => deposits.map(&:to_record) })
      end
    end
  end
end
