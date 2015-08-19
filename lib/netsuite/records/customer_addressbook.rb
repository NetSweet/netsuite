module NetSuite
  module Records
    class CustomerAddressbook
      include Support::Fields
      include Support::Records
      include Namespaces::ListRel

      # internalId is a bit strange on this record
      # https://github.com/NetSweet/netsuite/wiki/Miscellaneous-Web-Services-Quirks#customer

      fields :addressbook_address, :default_billing, :default_shipping, :internal_id, 
             :is_residential, :label

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when self.class
          initialize_from_record(attributes_or_record)
        when Hash
          attributes_or_record = attributes_or_record[:addressbook] if attributes_or_record[:addressbook]
          initialize_from_attributes_hash(attributes_or_record)
        end
      end

      def initialize_from_record(obj)
        self.addressbook_address = obj.addressbook_address
        self.default_billing  = obj.default_billing
        self.default_shipping = obj.default_shipping
        self.internal_id      = obj.internal_id
        self.is_residential   = obj.is_residential
        self.label            = obj.label
      end

    end
  end
end
