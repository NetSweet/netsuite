require 'spec_helper'

describe NetSuite::Records::AssemblyItem do
  let(:item) { described_class.new }

  describe '#member_list' do
    it 'can be set from attributes' do
      attributes = {
        :item_member => [{
          :item => { :internal_id => 1 },
          :quantity => 20
        }]
      }
      item.member_list = attributes
      expect(item.member_list).to be_kind_of(NetSuite::Records::MemberList)
      expect(item.member_list.item_member.length).to eql(1)

      expect(item.member_list.item_member.first.item.internal_id).to eq(1)
      expect(item.member_list.item_member.first.quantity).to eq(20)
    end
  end

  describe '#subsidiary_list' do
    it 'creates record refs from attributes' do
      item = described_class.new({
        subsidiary_list: {
          record_ref: [
            { internal_id: 1 },
            { internal_id: 2 },
          ]
        }
      })

      expect(item.subsidiary_list.record_ref[0].internal_id).to eq(1)
      expect(item.subsidiary_list.record_ref[1].internal_id).to eq(2)
    end
  end

  describe '#item_vendor_list' do
    it 'can be set from attributes' do
      attributes = {
        :item_vendor => {
          :vendor=>{
            :name=>"Spring Water",
            :"@xmlns:platform_core"=>"urn:core_2016_1.platform.webservices.netsuite.com",
            :@internal_id=>"20"
          },
         :purchase_price=>"16.14",
         :preferred_vendor=>true
        }
      }

      item.item_vendor_list = attributes
      expect(item.item_vendor_list).to be_kind_of(NetSuite::Records::ItemVendorList)
      expect(item.item_vendor_list.item_vendors.length).to eql(1)
    end

    it 'can be set from a ItemVendorList object' do
      item_vendor_list = NetSuite::Records::ItemVendorList.new
      item.item_vendor_list = item_vendor_list
      expect(item.item_vendor_list).to eql(item_vendor_list)
    end
  end
end
