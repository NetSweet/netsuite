require 'spec_helper'

describe NetSuite::Entities::FieldSupport do
  let(:klass) { Class.new.send(:include, NetSuite::Entities::FieldSupport) }
  let(:instance) do
    obj = klass.new
    obj.stub(:attributes).and_return({})
    obj
  end

  describe '.fields' do
    it 'calls .field with each argument passed to it' do
      [:one, :two, :three].each do |field|
        klass.should_receive(:field).with(field)
      end
      klass.fields(:one, :two, :three)
    end
  end

  describe '.field' do
    it 'defines instance accessor methods for the given field' do
      klass.field(:one)
      instance.one = 1
      instance.one.should eql(1)
    end
  end

end
