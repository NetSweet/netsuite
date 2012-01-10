module NetSuite
  module Records
    class ShipAddress
      include Support::Fields

      fields :ship_attention, :ship_addressee, :ship_phone, :ship_addr1, :ship_addr2,
        :ship_addr3, :ship_city, :ship_state, :ship_zip, :ship_country, :ship_is_residential

      def initialize(attrs = {})
        initialize_from_attributes_hash(attrs)
      end

    end
  end
end
