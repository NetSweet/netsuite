module NetSuite
  module Records
    class DepositPaymentList
      include Support::Fields
      include Namespaces::TranBank

      fields :deposit_payment

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def payment=(payments)
        case payments
        when Hash
          self.payments << DepositPayment.new(payments)
        when Array
          payments.each { |p| self.payments << DepositPayment.new(p) }
        end
      end

      def payments
        @payments ||= []
      end

      def to_record
        { "#{record_namespace}:depositPayment" => payments.map(&:to_record) }
      end

    end
  end
end
