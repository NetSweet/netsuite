module NetSuite
  module Records
    class InboundShipmentItemList < Support::Sublist
      include Namespaces::TranPurch

      sublist :item

      alias :items :item

    end
  end
end
