module NetSuite
  module Records
    class RoleList < Support::Sublist
      include Namespaces::ListEmp

      sublist :roles, Roles

      # role list is undocumented and has pretty funky XML:

      # <listEmp:rolesList>
      #   <listEmp:roles>
      #     <listEmp:selectedRole xmlns:platformCore="urn:core_2013_1.platform.webservices.netsuite.com" internalId="1001">
      #       <platformCore:name>Customer Service Rep</platformCore:name>
      #     </listEmp:selectedRole>
      #   </listEmp:roles>
      #   <listEmp:roles>
      #     <listEmp:selectedRole xmlns:platformCore="urn:core_2013_1.platform.webservices.netsuite.com" internalId="1002">
      #       <platformCore:name>Customer Service Rep Mgr</platformCore:name>
      #     </listEmp:selectedRole>
      #   </listEmp:roles>
      # </listEmp:rolesList>
    end
  end
end
