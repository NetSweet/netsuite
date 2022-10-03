module NetSuite
  module Records
    class KitItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_deleted, :get_list, :add, :delete, :search, :update, :update_list, :upsert

      fields :available_to_partners, :cost_estimate, :created_date, :defer_rev_rec, :description, :display_name,
        :dont_show_price, :enforce_min_qty_internally, :exclude_from_sitemap, :featured_description, :handling_cost,
        :hazmat_hazard_class, :hazmat_id, :hazmat_item_units, :hazmat_item_units_qty, :hazmat_shipping_name, :include_children,
        :is_donation_item, :is_fulfillable, :is_gco_compliant, :is_hazmat_item, :is_inactive, :is_online, :is_taxable, :item_id,
        :last_modified_date, :manufacturer, :manufactureraddr1, :manufacturer_city, :manufacturer_state, :manufacturer_tariff,
        :manufacturer_tax_id, :manufacturer_zip, :max_donation_amount, :meta_tag_html, :minimum_quantity, :mpn,
        :mult_manufacture_addr, :nex_tag_category, :no_price_message, :offer_support, :on_special, :out_of_stock_message,
        :page_title, :prices_include_tax, :print_items, :producer, :rate, :related_items_description, :schedule_b_number,
        :schedule_b_quantity, :search_keywords, :ship_individually, :shipping_cost, :shopping_dot_com_category,
        :shopzilla_category_id, :show_default_donation_amount, :specials_description, :stock_description, :store_description,
        :store_detailed_description, :store_display_name, :upc_code, :url_component, :use_marginal_rates, :vsoe_delivered,
        :vsoe_price, :weight

      record_refs :billing_schedule, :custom_form, :default_item_ship_method, :deferred_revenue_account, :department,
        :income_account, :issue_product, :item_revenue_category, :klass, :location, :parent, :pricing_group,
        :quantity_pricing_schedule, :revenue_allocation_group, :revenue_recognition_rule, :rev_rec_schedule, :sales_tax_code,
        :schedule_b_code, :ship_package, :soft_descriptor, :store_display_image, :store_display_thumbnail, :store_item_template,
        :tax_schedule, :weight_unit

      field :custom_field_list, CustomFieldList
      field :pricing_matrix, PricingMatrix
      field :subsidiary_list, RecordRefList
      field :member_list, ItemMemberList

      # TODO custom records need to be implemented
      # field :accounting_book_detail_list, ItemAccountingBookDetailList
      # field :cost_estimate_type, ItemCostEstimateType
      # field :country_of_manufacture, Country
      # field :create_revenue_plans_on, ItemCreateRevenuePlansOn
      # field :hazmat_packing_group, HazmatPackingGroup
      # field :item_carrier, ItemCarrier
      # field :item_options_list, ItemOptionsList
      # field :item_ship_method_list, RecordRefList
      # field :out_of_stock_behavior, ItemOutOfStockBehavior
      # field :overall_quantity_pricing_type, ItemOverallQuantityPricingType
      # field :preference_criterion, ItemPreferenceCriterion
      # field :presentation_item_list, PresentationItemList
      # field :product_feed_list, ProductFeedList
      # field :site_category_list, SiteCategoryList
      # field :sitemap_priority, SitemapPriority
      field :translations_list, TranslationList
      # field :vsoe_deferral, VsoeDeferral
      # field :vsoe_permit_discount, VsoePermitDiscount
      # field :vsoe_sop_group, VsoeSopGroup

      attr_reader :internal_id
      attr_accessor :external_id

      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def self.search_class_name
        "Item"
      end
    end
  end
end
