module NetSuite
  module Records
    class PriceLevel
      include Support::Fields
      include Support::Records
      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListAcct

      actions :get, :update, :get_list, :add, :delete, :search, :upsert

      # http://www.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2017_1/schema/record/pricelevel.html
      fields :discountpct, :name, :is_online, :update_existing_prices,
             :is_inactive

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end
    end
  end
end
