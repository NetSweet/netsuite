require 'spec_helper'

describe NetSuite::Records::ContactAddressbook do
  subject { described_class.new }

  describe '#record_type' do
    it 'returns a string of the record SOAP type' do
      expect(subject.record_type).to eql('listRel:ContactAddressbook')
    end
  end
end
