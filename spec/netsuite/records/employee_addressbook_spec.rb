require 'spec_helper'

describe NetSuite::Records::EmployeeAddressbook do
  subject { described_class.new }

  describe '#record_type' do
    it 'returns a string of the record SOAP type' do
      expect(subject.record_type).to eql('listRel:EmployeeAddressbook')
    end
  end
end
