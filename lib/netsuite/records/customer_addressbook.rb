module NetSuite
  module Records
    class CustomerAddressbook
      include Support::Fields
      include Support::Records
      include Namespaces::ListRel

      fields :default_shipping, :default_billing, :is_residential, :label, :attention, :addressee,
        :phone, :addr1, :addr2, :addr3, :city, :zip, :country, :addr_text, :override, :state

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes_or_record = {})
        case attributes_or_record
        when self.class
          initialize_from_record(attributes_or_record)
        when Hash
          attributes_or_record = attributes_or_record[:addressbook] if attributes_or_record[:addressbook]
          @internal_id = attributes_or_record.delete(:internal_id)
          initialize_from_attributes_hash(attributes_or_record)
        end
      end

      def initialize_from_record(obj)
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
        @internal_id          = obj.internal_id
      end

      def country=(country)
        if country.nil?
          attributes.delete(:country)
        else
          attributes[:country] = country_enum country
        end
      end

      def country_enum iso_country_code
        @@iso_country_code_to_enum ||= YAML.load_file(File.join(File.dirname(__FILE__),"../yaml/iso_country_code_to_enum.yml"))
        @@iso_country_code_to_enum[iso_country_code] || iso_country_code
      end

    end
  end
end
