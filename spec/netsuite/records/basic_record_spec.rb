require 'spec_helper'

describe 'basic records' do
  let(:basic_record_list) {
    [
      NetSuite::Records::Currency,
      NetSuite::Records::Location,
      NetSuite::Records::JobStatus,
      NetSuite::Records::TimeBill,
      NetSuite::Records::Customer
    ]
  }

  it 'can be initialized, has fields, and can be converted into a record' do
    basic_record_list.each do |record_class|
      record_instance = record_class.new

      # most records have a
      expect(record_class.fields.size).to be > 0
      expect(record_class.record_refs).to_not be_nil
      expect(record_instance).to respond_to(:internal_id)

      # NOTE all records have externalIds, not testing exernalId setter
      if record_class.respond_to?(:upsert)
        expect(record_instance).to respond_to(:external_id)
        expect(record_instance).to respond_to(:external_id=)
      end

      standard_fields = (record_class.fields - record_class.record_refs).to_a
      custom_object_fields = standard_fields.select { |f| !record_instance.send(f).nil? }
      standard_fields -= custom_object_fields

      # ensure that all fields can be set
      standard_fields.each { |f| expect(record_instance).to have_field(f) }
      record_class.record_refs.each { |f| expect(record_instance).to have_record_ref(f) }

      # TODO handle custom object fields

      6.times do
        record_instance.send(:"#{standard_fields.sample}=", "Test Value")
      end

      if !record_class.record_refs.empty?
        sample_record_ref_field = record_class.record_refs.to_a.sample

        record_instance.send(:"#{sample_record_ref_field}=".to_sym, { internal_id: 1 })
      end

      expect(record_instance.to_record).to be_a(Hash)

      # TODO should test for correct value output
    end
  end
end
