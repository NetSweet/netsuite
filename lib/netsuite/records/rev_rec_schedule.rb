# https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2015_1/schema/record/revrecschedule.html

module NetSuite
  module Records
    class RevRecSchedule
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :add, :update, :upsert, :delete, :search

      fields :initial_amount, :is_inactive, :name, :period_offset, :rev_rec_offset,
             :amortization_period

      record_refs :amortization_type, :recog_interval_src, :recurrence_type

      # recurrenceList	RevRecScheduleRecurrenceList	0..1

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
