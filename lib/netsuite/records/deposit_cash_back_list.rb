module NetSuite
  module Records
    class DepositCashBackList
      include Support::Fields
      include Namespaces::TranBank

      fields :deposit_cash_back

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def cashback=(cashbacks)
        case cashbacks
        when Hash
          self.cashbacks << DepositCashBack.new(cashbacks)
        when Array
          cashbacks.each { |cb| self.cashbacks << DepositCashBack.new(cb) }
        end
      end

      def cashbacks
        @cashbacks ||= []
      end

      def to_record
        { "#{record_namespace}:depositCashBack" => cashbacks.map(&:to_record) }
      end

    end
  end
end
