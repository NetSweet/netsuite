module NetSuite
  module Records
    class BillingSchedule
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :add, :delete, :upsert, :search

      fields :bill_for_actuals, :day_period, :frequency, :in_arrears, :initial_amount, :is_inactive,
        :is_public, :milestone_list, :month_dom, :month_dow, :month_dowim, :month_mode, :name,
        :number_remaining, :recurrence_dow_mask_list, :recurrence_list, :repeat_every, 
        :schedule_type, :series_start_date, :year_dom, :year_dow, :year_dowim, :year_dowim_month, 
        :year_mode, :year_month

      record_refs :initial_terms, :project, :recurrence_terms, :transaction

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
