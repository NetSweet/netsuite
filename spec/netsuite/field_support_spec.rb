require 'spec_helper'

describe NetSuite::FieldSupport do
  let(:klass) { Class.new.send(:include, NetSuite::FieldSupport) }
  let(:instance) { klass.new }

  describe '#initialize' do
    before do
      klass.field(:banana)
    end

    it 'stores the passed in attributes into the attributes instance variable' do
      instance = klass.new(:banana => 'for a monkey')
      instance.send(:attributes).should eql(:banana => 'for a monkey')
    end

    it 'ignores passed in attributes that are not in the fields set' do
      instance = klass.new(:apple => 'for a horse', :banana => 'for a monkey')
      instance.send(:attributes).should eql(:banana => 'for a monkey')
    end

    it 'renames attributes with swirlies'
  end

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
