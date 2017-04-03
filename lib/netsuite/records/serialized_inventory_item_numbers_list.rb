module NetSuite
  module Records
    class SerializedInventoryItemNumbersList < Support::Sublist
      include Namespaces::ListAcct

      sublist :numbers, SerializedInventoryItemNumbers

    end
  end
end