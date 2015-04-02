module NetSuite
  module Records
    class CustomerPaymentCreditList
      include Support::Fields
      include Namespaces::TranCust

      fields :credit

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def credit=(credits)
        case credits
          when Hash
            self.credits << CustomerPaymentCredit.new(credits)
          when Array
            credits.each { |credit| self.credits << CustomerPaymentCredit.new(credit) }
        end
      end

      def credits
        @credits ||= []
      end

      def to_record
        { "#{record_namespace}:credit" => credits.map(&:to_record) }
      end

    end
  end
end
