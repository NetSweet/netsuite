module NetSuite
  module Records
    class JournalEntryLine
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranGeneral

      fields :credit, :debit, :eliminate, :end_date, :gross_amt, :memo, :residual, :start_date, :tax1_amt, :tax_rate1
      field :custom_field_list, CustomFieldList
      record_refs :account, :department, :entity, :klass, :location, :schedule, :schedule_num, :tax1_acct, :tax_code

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
