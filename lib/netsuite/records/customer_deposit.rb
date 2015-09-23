module NetSuite
  module Records

    # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/customerdeposit.html

    class CustomerDeposit
      include Support::Actions
      include Support::RecordRefs
      include Support::Fields
      include Support::Records
      include Namespaces::TranCust

      actions :add, :get, :upsert

      fields :custom_form, :payment, :tran_date, :exchange_rate, :undep_funds, :memo,
             :check_num, :klass

      field :custom_field_list, CustomFieldList

      record_refs :customer, :sales_order, :account, :department, :payment_method

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
