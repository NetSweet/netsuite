module NetSuite
  module Records
    class TaxGroup
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      # NOTE `get_all` is not available API > 2017_1
      #      `search` is available API > 2016_2
      actions :get, :get_list, :add, :initialize, :delete, :update, :upsert, :search, :get_all

      fields :city, :county, :description, :include_children, :is_default, :is_inactive,
             :item_id, :piggyback, :rate, :state, :subsidiary_list, :unitprice1, :unitprice2,
             :zip

      record_refs :taxitem1, :taxitem2, :nexus_country, :tax_type

      # TODO
      # tax_item_list
      # subsidiary_list

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
