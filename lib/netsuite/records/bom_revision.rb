module NetSuite
  module Records
    class BomRevision
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list
    end
  end
end
