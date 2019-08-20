require 'spec_helper'

describe 'NetSuite::Records::*#refresh' do
  it 'should refresh a netsuite object in place' do
    shutter_fly_record = NetSuite::Records::Customer.new({ :internal_id => 123, :external_id => 'extid', :entity_id => 'Shutter Fly', :company_name => 'Shutter Fly, Inc.' })
    shutter_fly_record.errors = ['error 1', 'error 2']

    current_record = shutter_fly_record

    allow(NetSuite::Records::Customer).to receive(:get).and_return(shutter_fly_record)

    customer = NetSuite::Records::Customer.get({:internal_id => 123})

    expect(customer.errors.size).to eq(2)
    expect(customer.entity_id).to eq('Shutter Fly')
    expect(customer.company_name).to eq('Shutter Fly, Inc.')
    expect(customer.external_id).to eq('extid')
    expect(customer.internal_id).to eq(123)

    allow(NetSuite::Records::Customer).to receive(:get).and_return(NetSuite::Records::Customer.new({ :external_id => 'newextid', :entity_id => 'Totally New', :account_number => '1234' }))
    customer.refresh

    expect(customer.errors).to be_nil
    expect(customer.entity_id).to_not eq('Shutter Fly')
    expect(customer.account_number).to eq('1234')
    expect(customer.company_name).to be_nil
    expect(customer.external_id).to eq('newextid')
    expect(customer.internal_id).to eq(123)
  end
end
