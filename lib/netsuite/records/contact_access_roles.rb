module NetSuite
  module Records
    class ContactAccessRoles < NetSuite::Support::Base
      include Support::RecordRefs
      include Namespaces::ListRel

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/other/contactaccessroles.html?mode=package

      fields :email, :give_access, :password, :password2, :send_email

      record_refs :contact, :role
    end
  end
end
