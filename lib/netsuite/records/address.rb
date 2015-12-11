module NetSuite
  module Records
    class Address
      include Support::Fields
      include Support::Records
      include Namespaces::PlatformCommon

      # internalId is a bit strange on this record
      # https://github.com/NetSweet/netsuite/wiki/Miscellaneous-Web-Services-Quirks#customer

      fields :addr1, :addr2, :addressee, :addr_phone, :attention, :city, :custom_field_list, :internal_id, :override, :state, :zip

      field :country, NetSuite::Support::Country

      read_only_fields :addr_text

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when self.class
          initialize_from_record(attributes_or_record)
        when Hash
          attributes_or_record = attributes_or_record[:address] if attributes_or_record[:address]
          initialize_from_attributes_hash(attributes_or_record)
        end
      end

      def initialize_from_record(obj)
        self.addr1                = obj.addr1
        self.addr2                = obj.addr2
        self.addressee            = obj.addressee
        self.addr_phone           = obj.addr_phone
        self.addr_text            = obj.addr_text
        self.attention            = obj.attention
        self.city                 = obj.city
        self.country              = obj.country
        self.custom_field_list    = obj.custom_field_list
        self.internal_id          = obj.internal_id
        self.override             = obj.override
        self.state                = obj.state
        self.zip                  = obj.zip
      end

    end
  end
end
