require 'spec_helper'

describe NetSuite::Records::CustomList do
  let(:custom_list) { NetSuite::Records::CustomList.new }

  it 'has all the right fields' do
    expect(custom_list).to have_field(:script_id)
  end

  it "should handle the #custom_value_list" do
    custom_list.custom_value_list = { custom_value: [
      {
        value: "Value",
        value_id: 1
      }
    ]}

    expect(custom_list.custom_value_list).to be_kind_of(NetSuite::Support::Sublist)
    expect(custom_list.custom_value_list.custom_value.first).to be_kind_of(NetSuite::Records::CustomListCustomValue)
  end
end