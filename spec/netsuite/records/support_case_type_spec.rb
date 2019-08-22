require 'spec_helper'

describe NetSuite::Records::SupportCaseType do
  let(:support_case_type) { NetSuite::Records::SupportCaseType.new }

  it 'has all the right fields' do
    [
      :description, :is_inactive, :name
    ].each do |field|
      expect(support_case_type).to have_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :insert_before
    ].each do |record_ref|
      expect(support_case_type).to have_record_ref(record_ref)
    end
  end

end
