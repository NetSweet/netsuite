module NetSuite
  module Records
    class Roles < NetSuite::Support::Base
      include Support::RecordRefs
      include Namespaces::ListEmp

      record_refs :selected_role
    end
  end
end
