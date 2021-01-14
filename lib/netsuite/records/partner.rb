module NetSuite
  module Records

    class Partner
      include Support::Records
      include Support::Fields
      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListRel

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2020_2/schema/record/partner.html

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :search

      fields :alt_email, :alt_name, :bcn, :comments, :company_name, :date_created, :default_address,
             :eligible_for_commission, :email, :entity_id, :fax, :first_name, :give_access, :home_phone, :is_inactive,
             :is_person, :last_modified_date, :last_name, :login_as, :middle_name, :mobile_phone, :partner_code,
             :password, :password2, :phone, :phonetic_name, :print_on_check_as, :referring_url, :require_pwd_change,
             :salutation, :send_email, :sub_partner_login, :tax_id_num, :title, :url, :vat_reg_number

      record_refs :access_role, :klass, :custom_form, :default_tax_reg, :department, :image, :location, :parent, :subsidiary

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
