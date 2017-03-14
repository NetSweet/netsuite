module NetSuite
  module Records
    class InventoryNumberLocationsList < Support::Sublist
      include Namespaces::ListAcct

      sublist :locations, InventoryNumberLocations

    end
  end
end
