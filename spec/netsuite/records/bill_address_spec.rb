require 'spec_helper'

describe NetSuite::Records::BillAddress do
  let(:bill_address) { NetSuite::Records::BillAddress.new }

  it 'has all the right fields' do
    [
      :bill_attention, :bill_addressee, :bill_phone, :bill_addr1, :bill_addr2,
      :bill_addr3, :bill_city, :bill_state, :bill_zip, :bill_country
    ].each do |field|
      bill_address.should have_field(field)
    end
  end

  describe '#to_record' do
    before do
      bill_address.bill_attention = 'Mr. Smith'
      bill_address.bill_addressee = 'Mr. Robert Smith'
      bill_address.bill_phone     = '1234567890'
      bill_address.bill_addr1     = '123 Happy Lane'
      bill_address.bill_addr2     = '#4'
      bill_address.bill_addr3     = 'Box 6'
      bill_address.bill_city      = 'Los Angeles'
      bill_address.bill_state     = 'CA'
      bill_address.bill_zip       = '90007'
      bill_address.bill_country   = '_unitedStates'
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'platformCommon:billAttention' => 'Mr. Smith',
        'platformCommon:billAddressee' => 'Mr. Robert Smith',
        'platformCommon:billPhone'     => '1234567890',
        'platformCommon:billAddr1'     => '123 Happy Lane',
        'platformCommon:billAddr2'     => '#4',
        'platformCommon:billAddr3'     => 'Box 6',
        'platformCommon:billCity'      => 'Los Angeles',
        'platformCommon:billState'     => 'CA',
        'platformCommon:billZip'       => '90007',
        'platformCommon:billCountry'   => '_unitedStates'
      }
      bill_address.to_record.should eql(record)
    end
  end

  describe 'record_namespace' do
    it 'belongs to the platformCommon namespace' do
      bill_address.record_namespace.should eql('platformCommon')
    end
  end

end
