require 'spec_helper'

describe NetSuite::Support::RecordRefs do
  let(:klass) { Class.new.send(:include, NetSuite::Support::Fields) }
  let(:instance) { klass.new }

  context "assigning record reference" do
    it 'assigns a nil value for a field with a specified class' do
      klass.field(:record_test, NetSuite::Records::RecordRef)
      instance.record_test = nil
      instance.attributes.has_key?(:record_test).should be_false
    end
  end
end
