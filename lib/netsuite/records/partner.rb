module NetSuite
  module Records

    class Partner < Support::Base
      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListRel

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/partner.html

      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :search

      fields :phone, :first_name, :last_name, :is_inactive, :email

      record_refs :klass

      attr_reader   :internal_id
    end

  end
end