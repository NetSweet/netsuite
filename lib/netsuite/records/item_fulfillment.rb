module NetSuite
  module Records
  	class ItemFulfillment
		include Support::Fields
		include Support::RecordRefs
		include Support::Records
		include Support::Actions
		include Namespaces::TranSales

		actions :get, :initialize, :add, :delete

		fields :memo

		field :item_list, ItemFulfillmentItemList

		record_refs :created_from, :entity

		def initialize(attributes = {})
	        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
	        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
	        initialize_from_attributes_hash(attributes)
      	end

  	end
  end
end