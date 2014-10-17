module NetSuite
  module Records
    class Subsidiary
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :add, :delete, :get, :get_list, :get_select_value, :search,
        :update, :upsert

      fields :name, :is_inactive, :show_subsidiary_name, :url, :tran_prefix,
        :attention, :addressee, :addr_phone, :addr1, :addr2, :addr3, :city,
        :state, :zip, :country, :addr_text, :override, :ship_addr,
        :return_addr, :return_address1, :return_address2, :return_city,
        :return_state, :return_country, :return_zip, :legal_name,
        :is_elimination, :allow_payroll, :email, :fax, :edition,
        :federal_id_number, :addr_language, :non_consol, :consol,
        :ship_address1, :ship_address2, :ship_city, :ship_state, :ship_country,
        :ship_zip, :state1_tax_number, :ssn_or_tin, :inbound_email

      field :custom_field_list, CustomFieldList

      record_refs :check_layout, :inter_co_account, :parent, :logo,
        :page_logo, :fiscal_calendar, :tax_fiscal_calendar, :currency

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
