module NetSuite
  module Records
    class SerializedInventoryItemLocationsList < Support::Sublist
      include Namespaces::ListAcct

      sublist :locations, SerializedInventoryItemLocation

    end
  end
end
