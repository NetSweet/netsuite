module NetSuite
  module Records
    class GiftCertRedemption
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::TranSales

      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search

      fields :auth_code_amt_remaining, :auth_code_applied, :gift_cert_available

      record_refs :auth_code

      def initialize(attributes = {})
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
