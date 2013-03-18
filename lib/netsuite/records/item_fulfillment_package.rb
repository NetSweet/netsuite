module NetSuite
  module Records
    class ItemFulfillmentPackage
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Namespaces::TranSales

      fields :package_weight, :package_descr, :package_tracking_number

    end
  end
end
