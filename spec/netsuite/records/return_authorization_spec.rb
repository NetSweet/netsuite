require 'spec_helper'

describe NetSuite::Records::ReturnAuthorization do
  let(:return_authorization) { NetSuite::Records::ReturnAuthorization.new }


  describe '#shipping_address' do
    it 'can be set from attributes' do
      attributes = {
        :country => "_unitedStates",
        :attention => "William Sanders",
        :addressee => "William Sanders",
        :addr1 => "test1",
        :addr2 => "test2",
        :city => "San Francisco",
        :state => "CA",
        :zip => "94131",
        :addr_text => "William Sanders<br>William Sanders<br>test1<br>test2<br>San Francisco CA 94131",
        :override => false,
        :"@xmlns:platform_common" => "urn:common_2016_1.platform.webservices.netsuite.com"
      }

      return_authorization.shipping_address = attributes
      expect(return_authorization.shipping_address).to be_kind_of(NetSuite::Records::Address)
      expect(return_authorization.shipping_address.addressee).to eql("William Sanders")
    end

    it 'can be set from a ItemVendorList object' do
      shipping_address = NetSuite::Records::Address.new
      return_authorization.shipping_address = shipping_address
      expect(return_authorization.shipping_address).to eql(shipping_address)
    end
  end

  describe '#billing_address' do
    it 'can be set from attributes' do
      attributes = {
        :country => "_unitedStates",
        :attention => "William Sanders",
        :addressee => "William Sanders",
        :addr1 => "test1",
        :addr2 => "test2",
        :city => "San Francisco",
        :state => "CA",
        :zip => "94131",
        :addr_text => "William Sanders<br>William Sanders<br>test1<br>test2<br>San Francisco CA 94131",
        :override => false,
        :"@xmlns:platform_common" => "urn:common_2016_1.platform.webservices.netsuite.com"
      }

      return_authorization.billing_address = attributes
      expect(return_authorization.billing_address).to be_kind_of(NetSuite::Records::Address)
      expect(return_authorization.billing_address.addressee).to eql("William Sanders")
    end

    it 'can be set from a ItemVendorList object' do
      billing_address = NetSuite::Records::Address.new
      return_authorization.billing_address = billing_address
      expect(return_authorization.billing_address).to eql(billing_address)
    end
  end
end
