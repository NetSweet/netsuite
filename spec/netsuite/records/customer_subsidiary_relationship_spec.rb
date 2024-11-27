require 'spec_helper'

describe NetSuite::Records::CustomerSubsidiaryRelationship do
  let(:customer_subsidiary_record) { NetSuite::Records::CustomerSubsidiaryRelationship.new }

  it 'has all the right fields' do
    [
      :is_primary_sub,
      :is_inactive
    ].each do |field|
      expect(customer_subsidiary_record).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :entity,
      :primary_currency,
      :subsidiary
    ].each do |record_ref|
      expect(customer_subsidiary_record).to have_record_ref(record_ref)
    end
  end

  it 'can initialize with attributes' do
    attributes = {
      internal_id: '123',
      external_id: '456',
      is_primary_sub: true,
      is_inactive: false
    }
    record = NetSuite::Records::CustomerSubsidiaryRelationship.new(attributes)
    expect(record.internal_id).to eq('123')
    expect(record.external_id).to eq('456')
    expect(record.is_primary_sub).to be true
    expect(record.is_inactive).to be false
  end

  it 'can initialize without attributes' do
    record = NetSuite::Records::CustomerSubsidiaryRelationship.new
    expect(record.internal_id).to be_nil
    expect(record.external_id).to be_nil
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :value => 10,
          :internal_id => 'custfield_value'
        }
      }
      customer_subsidiary_record.custom_field_list = attributes
      expect(customer_subsidiary_record.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(customer_subsidiary_record.custom_field_list.custom_fields.length).to eql(1)
    end
  end


  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_person => true }) }

      it 'returns an CustomerSubsidiaryRelationship instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::CustomerSubsidiaryRelationship, {:external_id => 10}], {}).and_return(response)
        customer_subsidiary_relationship = NetSuite::Records::CustomerSubsidiaryRelationship.get(:external_id => 10)
        expect(customer_subsidiary_relationship).to be_kind_of(NetSuite::Records::CustomerSubsidiaryRelationship)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::CustomerSubsidiaryRelationship, {:external_id => 10}], {}).and_return(response)
        expect {
          NetSuite::Records::CustomerSubsidiaryRelationship.get(:external_id => 10)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::CustomerSubsidiaryRelationship with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:test_data) {
      {
        :entity => NetSuite::Records::RecordRef.new(internal_id: 1),
        :subsidiary => NetSuite::Records::RecordRef.new(internal_id: 2)
      }
    }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        customer_subsidiary_relationship = NetSuite::Records::CustomerSubsidiaryRelationship.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([customer_subsidiary_relationship], {}).
            and_return(response)
        expect(customer_subsidiary_relationship.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        customer_subsidiary_relationship = NetSuite::Records::CustomerSubsidiaryRelationship.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([customer_subsidiary_relationship], {}).
            and_return(response)
        expect(customer_subsidiary_relationship.add).to be_falsey
      end
    end
  end


end

