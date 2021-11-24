module NetSuite
  module Records
    class Bom
      include Support::Actions
      include Namespaces::ListBom

      actions :get, :get_list
    end
  end
end
