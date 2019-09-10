module NetSuite
  module Records
    class ContactAddressbook
      include Support::Fields
      include Support::Records
      include Namespaces::ListRel

      # address implementation changed
      # https://github.com/NetSweet/netsuite/pull/213

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2015_1/schema/other/customeraddressbook.html?mode=package

      fields :default_shipping, :default_billing, :is_residential, :label, :internal_id

      # NOTE API < 2014_2
      fields :attention, :addressee, :phone, :addr1, :addr2, :addr3, :city, :zip, :override, :state
      field :country, NetSuite::Support::Country
      read_only_fields :addr_text

      # NOTE API >= 2014_2
      field :addressbook_address, NetSuite::Records::Address

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
        if NetSuite::Configuration.api_version < "2014_2"
          self.default_shipping = obj.default_shipping
          self.default_billing  = obj.default_billing
          self.is_residential   = obj.is_residential
          self.label            = obj.label
          self.attention        = obj.attention
          self.addressee        = obj.addressee
          self.phone            = obj.phone
          self.addr1            = obj.addr1
          self.addr2            = obj.addr2
          self.addr3            = obj.addr3
          self.city             = obj.city
          self.zip              = obj.zip
          self.country          = obj.country
          self.addr_text        = obj.addr_text
          self.override         = obj.override
          self.state            = obj.state
          self.internal_id      = obj.internal_id
        else
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
end
