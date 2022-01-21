module NetSuite
  module Records
    class CurrencyRate
      include Support::Records
      include Support::Fields

      include Support::Actions
      include Support::RecordRefs
      include Namespaces::ListAcct

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/currencyrate.html

      actions :get, :get_list, :search

      fields :effective_date, :exchange_rate

      record_refs :base_currency, :transaction_currency

      #field :base_currency, Currency
      #field :transaction_currency, Currency

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
