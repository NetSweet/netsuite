module NetSuite
  module Records
    class AssemblyComponentList < Support::Sublist
      include Namespaces::TranInvt

      sublist :component, AssemblyComponent

      alias :components :component
    end
  end
end

