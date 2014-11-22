require 'spec_helper'

describe NetSuite::Records::CustomList do
  let(:custom_list) { NetSuite::Records::CustomList.new }

  it 'has all the right fields' do
    custom_list.should have_field(:script_id)
  end

  it "should handle the #custom_value_list" do
    custom_list.custom_value_list = { custom_value: [
      {
        value: "Value",
        value_id: 1
      }
    ]}

    custom_list.custom_value_list.should be_kind_of(NetSuite::Support::Sublist)
    custom_list.custom_value_list.custom_value.first.should be_kind_of(NetSuite::Records::CustomListCustomValue)
  end
end