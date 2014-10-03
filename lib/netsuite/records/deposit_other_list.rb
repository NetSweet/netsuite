module NetSuite
  module Records
    class DepositOtherList
      include Support::Fields
      include Namespaces::TranBank

      fields :deposit_other

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def other=(others)
        case others
        when Hash
          self.others << DepositOther.new(others)
        when Array
          others.each { |cb| self.others << DepositOther.new(cb) }
        end
      end

      def others
        @others ||= []
      end

      def to_record
        { "#{record_namespace}:depositOther" => others.map(&:to_record) }
      end

    end
  end
end
