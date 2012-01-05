require 'spec_helper'

describe NetSuite::Records::RecordRef do

  describe 'internal_id' do
    context 'when passing in as plain attribute to initialize' do
      it 'correctly sets the internal_id' do
        record_ref = NetSuite::Records::RecordRef.new(:internal_id => '1')
        record_ref.internal_id.should eql('1')
      end
    end

    context 'when passing in as swirly attributes to initialize' do
      it 'correctly sets the internal_id' do
        record_ref = NetSuite::Records::RecordRef.new(:@internal_id => '2')
        record_ref.internal_id.should eql('2')
      end
    end

    context 'when not passed in as an attribute to initialize' do
      it 'does not set an internal_id' do
        record_ref = NetSuite::Records::RecordRef.new
        record_ref.internal_id.should be_nil
      end
    end
  end

end
