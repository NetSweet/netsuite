require 'spec_helper'

describe NetSuite::Records::ItemMemberList do
  let(:list) { NetSuite::Records::ItemMemberList.new }

  it 'has a item_members attribute' do
    expect(list.item_members).to be_kind_of(Array)
  end

  describe '#to_record' do
    before do
      list.item_members << NetSuite::Records::ItemMember.new(:quantity => 3, :member_descr => "Component 5")
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:itemMember' => [{
          'listAcct:quantity' => 3,
          'listAcct:memberDescr' => "Component 5"
        }]
      }
      expect(list.to_record).to eql(record)
    end
  end

end
