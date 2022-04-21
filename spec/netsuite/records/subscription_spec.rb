require 'spec_helper'

describe NetSuite::Records::Subscription do

  before do
    NetSuite::Configuration.api_version = '2014_2'
  end

  let(:attributes) do
    {
      :subscription => {
        :subscribed          => true,
        :subscription        => NetSuite::Records::RecordRef.new(internal_id: '123123', name: 'My Sub'),
        :last_modified_date  => DateTime.new(2018, 1, 1, 0, 0, 0)
      }
    }
  end

  let(:list) { NetSuite::Records::Subscription.new(attributes) }

  it 'has all the right fields' do
    [
      :subscribed, :last_modified_date
    ].each do |field|
      expect(list).to have_field(field)
    end

    expect(list.subscription).to_not be_nil
  end

  describe '#initialize' do
    context 'when taking in a hash of attributes' do
      it 'sets the attributes for the object given the attributes hash' do
        expect(list.subscription.subscribed).to eql(true)
        expect(list.subscription.subscription.internal_id).to eql('123123')
        expect(list.subscription.subscription.name).to eql('My Sub')
        expect(list.subscription.last_modified_date).to_not be_nil
      end
    end
  end
end
