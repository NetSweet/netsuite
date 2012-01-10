require 'spec_helper'

module Foo
  module Bar
    class Baz
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
      instance.to_record.should eql({
        'listRel:source' => 'Google',
        'listRel:total'  => 100.0
      })
    end
  end

  describe '#record_type' do
    it 'returns a string of the record type to be used in a SOAP request' do
      instance.record_type.should eql('listRel:Baz')
    end
  end

end
