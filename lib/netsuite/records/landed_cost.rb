module NetSuite
  module Records
    class LandedCost
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::PlatformCommon

      fields :amount, :source

      record_refs :category, :transaction


    end
  end
end
