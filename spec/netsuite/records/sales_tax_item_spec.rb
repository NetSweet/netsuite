require 'spec_helper'

describe NetSuite::Records::SalesTaxItem do
  subject(:sales_tax_item) { described_class.new }

  it 'has all the right fields' do
    [
      :item_id, :display_name, :description, :rate, :is_inactive, :effective_from,
      :valid_until, :include_children, :eccode, :reverse_charge, :service,
      :exempt, :is_default, :exclude_from_tax_reports, :available, :export,
      :county, :city, :state, :zip
    ].each do |field|
      sales_tax_item.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :tax_type, :tax_agency, :tax_account, :purchase_account, :sale_account,
      :parent, :nexus_country
    ].each do |record_ref|
      sales_tax_item.should have_record_ref(record_ref)
    end
  end

  describe '#subsidiary_list' do
    it 'can be set from attributes'
    it 'can be set from a RecordRefList object'
  end
end
