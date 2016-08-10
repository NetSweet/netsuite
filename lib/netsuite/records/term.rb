module NetSuite
  module Records
    class Term
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :add, :delete, :upsert, :search

      fields :due_next_month_if_within_days, :name, :date_driven, :days_until_expiry, :days_until_next_due,
        :day_discount_expires, :day_of_month_net_due, :discount_percent, :discount_percent_date_driven, :is_inactive,
        :preferred

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
