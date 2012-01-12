require 'spec_helper'

describe NetSuite::Records::CustomFieldList do
  let(:list) { NetSuite::Records::CustomFieldList.new }

  it 'has a custom_fields attribute' do
    list.custom_fields.should be_kind_of(Array)
  end

  describe '#to_record' do
    it 'can represent itself as a SOAP record' do
      record = {
        'platformCore:customField' => []
      }
      list.to_record.should eql(record)
    end
  end

end
