require 'spec_helper'

describe NetSuite::Support::Fields do
  let(:klass) { Class.new.send(:include, NetSuite::Support::Fields) }
  let(:instance) { klass.new }

  describe '.fields' do
    context 'with arguments' do
      it 'calls .field with each argument passed to it' do
        [:one, :two, :three].each do |field|
          klass.should_receive(:field).with(field)
        end
        klass.fields(:one, :two, :three)
      end
    end

    context 'without arguments' do
      it 'returns a Set of the field arguments' do
        arguments = [:one, :two, :three]
        klass.fields(*arguments)
        klass.fields.should eql(Set.new(arguments))
      end
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
