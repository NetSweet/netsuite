module NetSuite
  module Records

    class Partner < Support::Base
      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListRel

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/partner.html

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :search

      fields :phone, :home_phone, :first_name, :last_name, :alt_name, :is_inactive, :email, :give_access,
             :partner_code, :is_person, :company_name, :eligible_for_commission

      record_refs :klass, :access_role

      attr_reader   :internal_id
    end

  end
end