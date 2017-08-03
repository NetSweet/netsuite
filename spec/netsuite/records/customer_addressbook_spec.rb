require 'spec_helper'

describe NetSuite::Records::CustomerAddressbook do
  subject { described_class.new }

  describe '#record_type' do
    it 'returns a string of the record SOAP type' do
      expect(subject.record_type).to eql('listRel:CustomerAddressbook')
    end
  end
end
