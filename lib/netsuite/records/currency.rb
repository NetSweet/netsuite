module NetSuite
  module Records
    class Currency
      include Support::Records
      include Support::Fields

      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListAcct

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/currency.html

      actions :get, :get_list, :get_all, :add, :update, :upsert, :upsert_list, :delete

      fields :name, :symbol, :is_base_currency, :is_inactive, :override_currency_format, :display_symbol, :symbol_placement,
             :locale, :formatSample, :exchangeRate, :fx_rate_update_timezone, :incl_in_fx_rate_updates, :currency_precision

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
