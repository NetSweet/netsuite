module NetSuite
  module Records
    class AccountingPeriod
      include Support::Fields
      include Support::RecordRefs
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :add, :delete, :upsert, :search

      fields :allow_non_gl_changes, :end_date, :is_adjust, :is_quarter, :is_year, :period_name, :start_date, :closed

      record_refs :parent

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
