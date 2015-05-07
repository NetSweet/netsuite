require 'spec_helper'

describe NetSuite::Records::ItemFulfillmentItemList do
	it "should create a list with a single hash as an argument" do
		i = NetSuite::Records::ItemFulfillmentItemList.new(item: {
			quantity: 2,
			item_receive: true
		})

		expect(i.item.size).to eq(1)
		expect(i.to_record["tranSales:item"].size).to eq(1)
	end

	it "should create a list with a list of hashes" do
		i = NetSuite::Records::ItemFulfillmentItemList.new(item: [
			{
				quantity: 2,
				item_receive: true
			},
			{
				quantity: 1,
				item_receive: false
			}
		])

		expect(i.item.size).to eq(2)
		expect(i.to_record["tranSales:item"].size).to eq(2)
	end

	it "should properly render the replace_all option" do
		i = NetSuite::Records::ItemFulfillmentItemList.new(replace_all: false)

		expect(i.sublist_key).to eq(:item)
		expect(i.to_record["tranSales:replaceAll"]).to eq(false)
	end

	it "should accept the shorthand append syntax" do
		i = NetSuite::Records::ItemFulfillmentItemList.new
		i << { quantity: 1 }
		expect(i.item.size).to eq(1)
	end
end