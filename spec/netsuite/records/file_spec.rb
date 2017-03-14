require 'spec_helper'

describe NetSuite::Records::File do
  let(:file) { NetSuite::Records::File.new }

  it 'has all the right record refs' do
    [:folder, :klass].each do |record_ref|
      expect(file).to have_record_ref(record_ref)
    end
  end
end
