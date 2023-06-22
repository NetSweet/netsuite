module NetSuite
  module Records
    class Account
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :add, :update, :delete, :search, :upsert

      fields :acct_name, :acct_number, :acct_type, :cash_flow_rate, :cur_doc_num, :description, :eliminate, :exchange_rate,
        :general_rate, :include_children, :inventory, :is_inactive, :opening_balance, :revalue, :tran_date, :balance

      record_refs :billable_expenses_acct, :category1099misc, :currency, :deferral_acct, :department, :klass, :location, :parent

      field :subsidiary_list, RecordRefList

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
