module NetSuite
  module Records
    class JournalEntry
      include Support::Fields
      include Support::RecordRefs

      fields :approved, :created_date, :exchange_rate, :last_modified_date, :reversal_date, :reversal_defer, :reversal_entry,
        :tran_date, :tran_id

      field :custom_field_list, CustomFieldList

      record_refs :created_from, :currency, :custom_form, :department, :klass, :location, :parent_expense_alloc,
        :posting_period, :subsidiary, :to_subsidiary

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
