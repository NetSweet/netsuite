require 'spec_helper'

describe NetSuite::Records::Location do
  let(:location) { NetSuite::Records::Location.new }

  # <element name="classTranslationList" type="listAcct:ClassTranslationList" minOccurs="0"/>
  # <element name="subsidiaryList" type="platformCore:RecordRefList" minOccurs="0"/>
  # <element name="customFieldList" type="platformCore:CustomFieldList" minOccurs="0"/>
  it 'has all the right attributes' do
    [
      :addr1, :addr2, :addr3, :addr_phone, :addr_text, :addressee, :attention, :city, :country, :include_children, :is_inactive,
      :make_inventory_available, :make_inventory_available_store, :name, :override, :state, :tran_prefix, :zip
    ].each do |field|
      location.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :logo, :parent
    ].each do |record_ref|
      location.should have_record_ref(record_ref)
    end
  end

end
