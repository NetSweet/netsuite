module NetSuite
  module Records
    class BillOfMaterialRevision
      include Support::Actions
      include Namespaces::ListBom

      actions :get, :get_list
    end
  end
end
