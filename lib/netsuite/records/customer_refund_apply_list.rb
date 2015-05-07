module NetSuite
  module Records
    class CustomerRefundApplyList
      include Namespaces::TranCust

      # TODO should use new sublist implementation

      attr_accessor :replace_all

      def initialize(attributes = {})
        case attributes[:apply]
        when Hash
          applies << CustomerRefundApply.new(attributes[:apply])
        when Array
          attributes[:apply].each { |apply| applies << CustomerRefundApply.new(apply) }
        end
      end

      def applies
        @applies ||= []
      end

      def to_record
        rec = { "#{record_namespace}:apply" => applies.map(&:to_record) }
        rec[:@replaceAll] = @replace_all unless @replace_all.nil?
        rec
      end

    end
  end
end
