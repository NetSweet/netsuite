module NetSuite
  module Records

    class Partner
      include Support::Records
      include Support::Fields
      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListRel

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/partner.html

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :search

      fields :phone, :home_phone, :first_name, :last_name, :alt_name, :is_inactive, :email, :give_access,
             :partner_code, :is_person, :company_name, :eligible_for_commission, :entity_id, :last_modified_date,
             :date_created, :title, :mobile_phone, :comments, :middle_name, :send_email, :password, :password2

      record_refs :klass, :access_role, :department, :subsidiary

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end

  end
end
