# TODO needs spec

module NetSuite
  module Records
    class BaseRefList < Support::Sublist
      include Support::Actions
      include Namespaces::PlatformCore

      actions :get_select_value

      sublist :base_ref, RecordRef

      alias :base_refs :base_ref

    end
  end
end
