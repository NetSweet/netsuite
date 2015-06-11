require 'spec_helper'

describe NetSuite::Records::InventoryDetail do
  let(:item) { NetSuite::Records::InventoryDetail.new }

  it 'has all the right record refs' do
    [
      :custom_form
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end
end
