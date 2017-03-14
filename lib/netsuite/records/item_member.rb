module NetSuite
  module Records
    class ItemMember
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::ListAcct

      fields :member_descr, :component_yield, :bom_quantity, :quantity,
        :member_unit, :vsoe_delivered, :tax_code, :tax_rate, :effective_date,
        :obsolete_date, :line_number, :vsoe_deferral, :vsoe_permit_discount

      record_refs :tax_schedule, :item, :effective_revision,
        :obsolete_revision

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
