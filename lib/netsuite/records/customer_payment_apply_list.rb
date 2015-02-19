module NetSuite
  module Records
    class CustomerPaymentApplyList
      include Support::Fields
      include Namespaces::TranCust

      fields :apply

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def apply=(applies)
        case applies
          when Hash
            self.applies << CustomerPaymentApply.new(applies)
          when Array
            applies.each { |apply| self.applies << CustomerPaymentApply.new(apply) }
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
