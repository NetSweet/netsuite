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
      item.member_list.should be_kind_of(NetSuite::Records::MemberList)
      item.member_list.item_member.length.should eql(1)

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
end
