module NetSuite
  module Records
    class JournalEntry
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranGeneral

      actions :get, :add, :delete

      fields :approved, :created_date, :exchange_rate, :last_modified_date, :reversal_date, :reversal_defer, :reversal_entry,
        :tran_date, :tran_id

      field :custom_field_list, CustomFieldList
      field :line_list,         JournalEntryLineList

      record_refs :created_from, :currency, :custom_form, :department, :klass, :location, :parent_expense_alloc,
        :posting_period, :subsidiary, :to_subsidiary

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end

    end
  end
end
