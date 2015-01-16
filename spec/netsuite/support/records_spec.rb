require 'spec_helper'

module Foo
  module Bar
    class Baz
      include NetSuite::Support::Fields
      include NetSuite::Support::Records

      def attributes
        { :source => 'Google', :total => 100.0 }
      end
    end
  end
end

describe NetSuite::Support::Records do
  let(:instance) { Foo::Bar::Baz.new }

  describe '#record_type' do
    it 'returns a hash of attributes to be used in a SOAP request' do
      expect(instance.to_record).to eql({
        'platformCore:source' => 'Google',
        'platformCore:total'  => 100.0
      })
    end
  end

  describe '#record_type' do
    it 'returns a string of the record type to be used in a SOAP request' do
      expect(instance.record_type).to eql('platformCore:Baz')
    end
  end

end
