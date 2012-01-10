module NetSuite
  module Records
    class BillAddress
      include Support::Fields

      fields :bill_attention, :bill_addressee, :bill_phone, :bill_addr1, :bill_addr2,
        :bill_addr3, :bill_city, :bill_state, :bill_zip, :bill_country

      def initialize(attrs = {})
        initialize_from_attributes_hash(attrs)
      end

    end
  end
end
