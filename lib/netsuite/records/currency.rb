module NetSuite
  module Records
    class Currency
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :get_all, :add, :delete, :search

      fields :display_symbol, :exchange_rate, :format_sample, :incl_in_fx_rate_updated, :is_base_currency, :is_inactive,
        :name, :override_currency_format, :symbol


      attr_reader   :internal_id
      attr_accessor :external_id
      attr_accessor :search_joins

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
