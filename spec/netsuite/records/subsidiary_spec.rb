require 'spec_helper'

describe NetSuite::Records::Subsidiary do
  let(:subsidiary) { described_class.new }

  it 'has all the right fields' do
    [ :name, :is_inactive, :show_subsidiary_name, :url, :tran_prefix, :attention,
      :addressee, :addr_phone, :addr1, :addr2, :addr3, :city, :state, :zip,
      :country, :addr_text, :override, :ship_addr, :return_addr, :return_address1,
      :return_address2, :return_city, :return_state, :return_country, :return_zip,
      :legal_name, :is_elimination, :allow_payroll, :email, :fax, :edition,
      :federal_id_number, :addr_language, :non_consol, :consol, :ship_address1,
      :ship_address2, :ship_city, :ship_state, :ship_country, :ship_zip,
      :state1_tax_number, :ssn_or_tin, :inbound_email ].each do |field|
      expect(subsidiary).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [ :check_layout, :inter_co_account, :parent, :logo, :page_logo,
      :fiscal_calendar, :tax_fiscal_calendar, :currency ].each do |record_ref|
      expect(subsidiary).to have_record_ref(record_ref)
    end
  end
end
