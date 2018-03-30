module NetSuite
  module Records
    class InboundShipmentItemList < Support::Sublist
      include Namespaces::TranPurch

      sublist :inbound_shipment_items, InboundShipmentItem

      alias :items_list :inbound_shipment_items
    end
  end
end
