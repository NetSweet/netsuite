module NetSuite
  module Records
    class ContactAccessRoles
      include Support::Records
      include Support::Fields
      include Support::RecordRefs
      include Namespaces::ListRel

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/other/contactaccessroles.html?mode=package

      fields :email, :give_access, :password, :password2, :send_email

      record_refs :contact, :role

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
