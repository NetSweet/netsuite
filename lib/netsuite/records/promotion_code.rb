# https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2014_1/schema/record/promotioncode.html

module NetSuite
  module Records
    class PromotionCode
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListMkt

      actions :get, :get_list, :add, :search, :delete, :update, :upsert

      fields :code, :code_pattern, :description, :discount_type, :display_line_discounts, :end_date,
             :exclude_items, :is_inactive, :is_public, :minimum_order_amount, :name, :number_to_generate,
             :rate, :start_date

      record_refs :free_ship_method, :implementation, :custom_form

      # TODO custom records need to be implemented
      # field :currency_list, PromotionCodeCurrencyList
      # field :apply_discount_to, PromotionCodeApplyDiscountTo
      # field :items_list, PromotionCodeItemsList
      # field :partners_list, PromotionCodePartnersList
      # field :use_type, PromotionCodeUseType

      attr_reader   :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

    end
  end
end
