module NetSuite
  module Records
    class BomRevision
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :search
    end
  end
end
