module NetSuite
  module Records
    class PaymentMethod
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :add, :delete, :get, :get_list, :search, :update, :upsert, :upsert_list

      fields :credit_card, :express_checkout_arrangement, :is_debit_card, :is_inactive, :is_online, :name,
        :pay_pal_email_address, :undep_funds, :use_express_checkout

      record_ref :account

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
