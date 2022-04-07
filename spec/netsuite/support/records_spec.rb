require 'spec_helper'

module Foo
  module Bar
    class Baz
      include NetSuite::Support::Fields
      include NetSuite::Support::RecordRefs
      include NetSuite::Support::Records
      include NetSuite::Namespaces::TranSales

      fields :source, :total
      field :null_field_list, NetSuite::Records::NullFieldList

      record_ref :related_record
    end
  end
end

describe NetSuite::Support::Records do
  let(:instance) { Foo::Bar::Baz.new }

  describe '#to_record' do
    it 'returns a hash of attributes to be used in a SOAP request' do
      instance.source = 'Google'
      instance.total = 100.0

      expect(instance.to_record).to eql({
        'tranSales:source' => 'Google',
        'tranSales:total'  => 100.0
      })
    end

    it 'uses the records namespace for the outer elements namespace and the field values namespace for the inner elements namespace' do
      instance.related_record = NetSuite::Records::RecordRef.new(name: 'blah')

      expect(instance.to_record).to eq({
        'tranSales:relatedRecord' => {
          'platformCore:name' => 'blah',
        },
      })
    end

    it 'uses the fields namespace for the outer elements namespace for NullFieldList value' do
      instance.null_field_list.name = 'source'

      expect(instance.to_record).to eq({
        'platformCore:nullFieldList' => {
          'platformCore:name' => 'source',
        },
      })
    end
  end

  describe '#record_type' do
    it 'returns a string of the record type to be used in a SOAP request' do
      expect(instance.record_type).to eql('tranSales:Baz')
    end
  end

end
