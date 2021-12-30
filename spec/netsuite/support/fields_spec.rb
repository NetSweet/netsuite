require 'spec_helper'

describe NetSuite::Support::Fields do
  let(:klass) do
    Class.new do
      include NetSuite::Support::Fields
    end
  end
  let(:instance) { klass.new }

  describe '.fields' do
    context 'with arguments' do
      it 'calls .field with each argument passed to it' do
        [:one, :two, :three].each do |field|
          expect(klass).to receive(:field).with(field)
        end
        klass.fields(:one, :two, :three)
      end
    end

    context 'without arguments' do
      it 'returns a Set of the field arguments' do
        arguments = [:one, :two, :three]
        klass.fields(*arguments)
        expect(klass.fields).to eql(Set.new(arguments))
      end
    end
  end

  describe '.field' do
    it 'defines instance accessor methods for the given field' do
      klass.field(:one)
      instance.one = 1
      expect(instance.one).to eql(1)
    end

    it 'errors when already a field' do
      DummyRecord = klass

      klass.field :one

      expect { klass.field :one }.to raise_error('one already defined on DummyRecord')
    end

    it 'errors when conflicting with a public method' do
      DummyRecordWithMethod = Class.new(klass) do
        def existing_method
        end
      end

      expect { DummyRecordWithMethod.field :existing_method }.to raise_error('existing_method conflicts with a method defined on DummyRecordWithMethod')
    end
  end

  describe '.read_only_fields' do
    context 'with arguments' do
      it 'calls .read_only_field with each argument passed to it' do
        [:one, :two, :three].each do |field|
          expect(klass).to receive(:read_only_field).with(field)
        end
        klass.read_only_fields(:one, :two, :three)
      end
    end

    context 'without arguments' do
      it 'returns a Set of the read_only_field arguments' do
        arguments = [:one, :two, :three]
        klass.read_only_fields(*arguments)
        expect(klass.read_only_fields).to eql(Set.new(arguments))
      end
    end
  end

  describe '.read_only_field' do
    it 'defines instance accessor methods for the given field' do
      expect(klass).to receive(:field).with(:one)
      klass.read_only_field(:one)
    end
  end

  describe '.search_only_fields' do
    context 'with arguments' do
      it 'calls .search_only_field with each argument passed to it' do
        [:one, :two, :three].each do |field|
          expect(klass).to receive(:search_only_field).with(field)
        end
        klass.search_only_fields(:one, :two, :three)
      end
    end

    context 'without arguments' do
      it 'returns a Set of the search_only_field arguments' do
        arguments = [:one, :two, :three]
        klass.search_only_fields(*arguments)
        expect(klass.search_only_fields).to eql(Set.new(arguments))
      end
    end
  end

  describe '.search_only_field' do
    it 'defines instance accessor methods for the given field' do
      expect(klass).to receive(:field).with(:one)
      klass.search_only_field(:one)
    end
  end

end
