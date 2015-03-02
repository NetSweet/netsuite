module NetSuite
  module Records
    class VendorPaymentApplyList
      include Support::Fields
      include Namespaces::TranPurch

      fields :apply

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def apply=(applies)
        case applies
          when Hash
            @applies = [VendorPaymentApply.new(applies)]
          when Array
            @applies = applies.map { |apply| VendorPaymentApply.new(apply) }
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
