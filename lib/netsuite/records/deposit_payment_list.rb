module NetSuite
  module Records
    class DepositPaymentList
      include Support::Fields
      include Namespaces::TranBank

      attr_accessor :replace_all

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
        rec = { "#{record_namespace}:depositPayment" => payments.map(&:to_record) }
        rec[:@replaceAll] = @replace_all unless @replace_all.nil?
        rec
      end
    end
  end
end
