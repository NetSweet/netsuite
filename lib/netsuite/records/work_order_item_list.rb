module NetSuite
  module Records
    class WorkOrderItemList < Support::Sublist
      include Namespaces::TranInvt

      sublist :item, WorkOrderItem

      alias :items :item
    end
  end
end
