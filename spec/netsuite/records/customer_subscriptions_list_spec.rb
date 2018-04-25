require 'spec_helper'

describe NetSuite::Records::CustomerSubscriptionsList do
  let(:list) { NetSuite::Records::CustomerSubscriptionsList.new }

  it 'has a subscriptions attribute' do
    expect(list.subscriptions).to be_kind_of(Array)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do

      record = {
        'listRel:subscriptions' => []
      }
      expect(list.to_record).to eql(record)
    end
  end
end
