module NetSuite
  module Records
    class CashRefundItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranCust

      field :amount

      record_refs :item, :klass

      def initialize(attributes_or_record = {})
        initialize_from_attributes_hash(attributes_or_record)
      end

    end
  end
end
