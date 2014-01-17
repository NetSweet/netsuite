module NetSuite
  module Records
    # Adding a Customer Deposit example. The customer associated with the sales
    # order would be linked to the deposit.
    #
    #   deposit = CustomerDeposit.new
    #   deposit.sales_order = RecordRef.new(internal_id: 7279)
    #   deposit.payment = 20
    #   deposit.add
    #
    class CustomerDeposit
      include Support::Actions
      include Support::RecordRefs
      include Support::Fields
      include Support::Records
      include Namespaces::TranCust

      actions :add

      fields :custom_form, :payment, :tran_date, :exchange_rate

      record_refs :customer, :sales_order

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
