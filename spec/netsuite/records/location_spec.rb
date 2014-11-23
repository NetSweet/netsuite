require 'spec_helper'

describe NetSuite::Records::Location do
  let(:location) { NetSuite::Records::Location.new }

  it 'has all the right attributes' do
    [
      :addr1, :addr2, :addr3, :addr_phone, :addr_text, :addressee, :attention, :city, :country, :include_children, :is_inactive,
      :make_inventory_available, :make_inventory_available_store, :name, :override, :state, :tran_prefix, :zip
    ].each do |field|
      expect(location).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :logo, :parent
    ].each do |record_ref|
      expect(location).to have_record_ref(record_ref)
    end
  end

  describe '#class_translation_list' do
    it 'can be set from attributes'
    it 'can be set from a ClassTranslationList object'
  end

  describe '#subsidiary_list' do
    it 'can be set from attributes'
    it 'can be set from a RecordRefList object'
  end

  describe '#custom_field_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomFieldList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :city => 'Los Angeles' }) }

      it 'returns a Location instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Location, {:external_id => 1}], {}).and_return(response)
        location = NetSuite::Records::Location.get(:external_id => 1)
        expect(location).to be_kind_of(NetSuite::Records::Location)
        expect(location.city).to eql('Los Angeles')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Location, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::Location.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Location with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
