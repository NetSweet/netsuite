module NetSuite
  module Records
    class ContactAccessRolesList < Support::Sublist
      include Namespaces::ListRel

      sublist :contact_roles, ContactAccessRoles
    end
  end
end
