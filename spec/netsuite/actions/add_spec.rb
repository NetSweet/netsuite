require 'spec_helper'

describe NetSuite::Actions::Add do

  context 'Customer' do
    let(:attributes) do
      {
        :entity_id    => 'Shutter Fly',
        :company_name => 'Shutter Fly, Inc.'
      }
    end

    before do
      savon.expects(:add).with({
        'platformMsgs:record' => {
          'listRel:entityId'    => 'Shutter Fly',
          'listRel:companyName' => 'Shutter Fly, Inc.'
        },
        :attributes! => {
          'platformMsgs:baseRef' => {
            'xsi:type' => 'listRel:Customer'
          }
        }
      }).returns(:add_customer)
    end

    it 'makes a valid request to the NetSuite API' do
      NetSuite::Actions::Add.call(attributes)
    end

    it 'returns a valid Response object' do
      response = NetSuite::Actions::Add.call(attributes)
      response.should be_kind_of(NetSuite::Response)
    end
  end

end
