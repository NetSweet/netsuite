module NetSuite
  module Records
    class InterCompanyJournalEntry
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranGeneral

      actions :get, :get_list, :add, :delete, :search, :upsert

      fields :approved, :created_date, :exchange_rate, :is_book_specific, :last_modified_date, :memo, :reversal_date, :reversal_defer,
        :reversal_entry, :tran_date, :tran_id

      field :custom_field_list, CustomFieldList
      field :line_list,         InterCompanyJournalEntryLineList

      record_refs :created_from, :currency, :custom_form, :department, :klass, :location, :parent_expense_alloc,
        :posting_period, :subsidiary, :to_subsidiary

      attr_reader   :internal_id
      attr_accessor :external_id

        def initialize(attributes = {})
          @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
          @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
          initialize_from_attributes_hash(attributes)
        end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end

      def self.search_class_name
        "Transaction"
      end

      def self.search_class_namespace
        "tranSales"
      end

    end
  end
end
