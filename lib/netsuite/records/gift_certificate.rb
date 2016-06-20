module NetSuite
  module Records
    class GiftCertificate
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :amount_remaining, :created_date, :email, :expiration_date, :gift_cert_code,
             :last_modified_date, :message, :name, :original_amount, :sender

      attr_reader :internal_id
      # NOTE as of 2016_1 there is no external ID available for this record

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)

        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
