module NetSuite
  module Records
    class LotNumberedInventoryItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      # http://www.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2018_2/schema/record/lotnumberedinventoryitem.html

      # TODO
      # countryOfManufacture	Country
      # hazmatPackingGroup	HazmatPackingGroup
      # accountingBookDetailList	ItemAccountingBookDetailList
      # costEstimateType	ItemCostEstimateType
      # costingMethod	ItemCostingMethod
      # invtClassification	ItemInvtClassification
      # matrixType	ItemMatrixType
      # itemOptionsList	ItemOptionsList
      # outOfStockBehavior	ItemOutOfStockBehavior
      # overallQuantityPricingType	ItemOverallQuantityPricingType
      # preferenceCriterion	ItemPreferenceCriterion
      # itemVendorList	ItemVendorList
      # weightUnit	ItemWeightUnit
      # hierarchyVersionsList	LotNumberedInventoryItemHierarchyVersionsList
      # numbersList	LotNumberedInventoryItemNumbersList
      # periodicLotSizeType	PeriodicLotSizeType
      # presentationItemList	PresentationItemList
      # productFeedList	ProductFeedList

      field :pricing_matrix, PricingMatrix
      field :custom_field_list, CustomFieldList
      field :bin_number_list, BinNumberList
      field :locations_list, LocationsList
      field :item_vendor_list, ItemVendorList
      field :matrix_option_list, MatrixOptionList
      field :subsidiary_list, RecordRefList

      actions :get, :get_list, :add, :delete, :search, :update, :upsert, :update_list

      record_refs :alternate_demand_source_item, :asset_account, :bill_exch_rate_variance_acct,
                  :billing_schedule, :bill_price_variance_acct, :bill_qty_variance_acct,
                  :klass, :cogs_account, :cost_category, :create_revenue_plans_on,
                  :custom_form, :default_item_ship_method, :deferred_revenue_account,
                  :demand_source, :department, :dropship_expense_account, :gain_loss_account,
                  :income_account, :interco_cogs_account, :interco_income_account,
                  :issue_product, :item_revenue_category, :location, :parent, :preferred_location,
                  :pricing_group, :purchase_price_variance_acct, :purchase_tax_code, :purchase_unit,
                  :quantity_pricing_schedule, :revenue_allocation_group, :revenue_recognition_rule,
                  :rev_rec_forecast_rule, :rev_rec_schedule, :sales_tax_code, :sale_unit,
                  :ship_package, :soft_descriptor, :stock_unit, :store_display_image,
                  :store_display_thumbnail, :store_item_template, :supply_lot_sizing_method,
                  :supply_replenishment_method, :supply_type, :tax_schedule, :units_type, :vendor

      # TODO
      # itemNumberOptionsList	RecordRefList
      # itemShipMethodList	RecordRefList
      # subsidiaryList	RecordRefList
      # scheduleBCode	ScheduleBCode
      # itemCarrier	ShippingCarrier
      # siteCategoryList	SiteCategoryList
      # sitemapPriority	SitemapPriority
      # translationsList	TranslationList
      # vsoeDeferral	VsoeDeferral
      # vsoePermitDiscount	VsoePermitDiscount
      # vsoeSopGroup	VsoeSopGroup

      fields  :auto_lead_time, :auto_preferred_stock_level, :auto_reorder_point, :available_to_partners,
              :copy_description, :direct_revenue_posting, :dont_show_price, :enforce_min_qty_internally,
              :exclude_from_sitemap, :include_children, :is_donation_item, :is_drop_ship_item, :is_gco_compliant,
              :is_hazmat_item, :is_inactive, :is_online, :is_special_order_item, :is_store_pickup_allowed,
              :is_taxable, :match_bill_to_receipt, :mult_manufacture_addr, :offer_support, :on_special,
              :prices_include_tax, :producer, :round_up_as_component, :seasonal_demand, :ship_individually,
              :show_default_donation_amount, :track_landed_cost, :use_bins, :use_marginal_rates, :vsoe_delivered,
              :created_date, :expiration_date, :last_invt_count_date, :last_modified_date, :next_invt_count_date,
              :average_cost, :cost, :cost_estimate, :default_return_cost, :demand_modifier, :fixed_lot_size,
              :handling_cost, :hazmat_item_units_qty, :last_purchase_price, :max_donation_amount,
              :on_hand_value_mli, :preferred_stock_level, :preferred_stock_level_days, :purchase_order_amount,
              :purchase_order_quantity, :purchase_order_quantity_diff, :quantity_available,
              :quantity_back_ordered, :quantity_committed, :quantity_on_hand, :quantity_on_order,
              :rate, :receipt_amount, :receipt_quantity, :receipt_quantity_diff, :reorder_point,
              :safety_stock_level, :shipping_cost, :total_value, :transfer_price, :vsoe_price,
              :weight, :backward_consumption_days, :demand_time_fence, :forward_consumption_days,
              :invt_count_interval, :lead_time, :maximum_quantity, :minimum_quantity, :periodic_lot_size_days,
              :reorder_multiple, :reschedule_in_days, :reschedule_out_days, :safety_stock_level_days,
              :schedule_b_quantity, :shopzilla_category_id, :supply_time_fence, :costing_method_display,
              :cost_units, :currency, :display_name, :featured_description, :handling_cost_units,
              :hazmat_hazard_class, :hazmat_id, :hazmat_item_units, :hazmat_shipping_name, :item_id,
              :manufacturer, :manufacturer_addr1, :manufacturer_city, :manufacturer_state,
              :manufacturer_tariff, :manufacturer_tax_id, :manufacturer_zip, :matrix_item_name_template,
              :meta_tag_html, :minimum_quantity_units, :mpn, :nex_tag_category, :no_price_message,
              :out_of_stock_message, :page_title, :preferred_stock_level_units, :purchase_description,
              :quantity_on_hand_units, :quantity_reorder_units, :related_items_description,
              :reorder_point_units, :safety_stock_level_units, :sales_description, :schedule_b_number,
              :search_keywords, :serial_numbers, :shipping_cost_units, :shopping_dot_com_category,
              :specials_description, :stock_description, :store_description, :store_detailed_description,
              :store_display_name, :upc_code, :url_component, :vendor_name, :weight_units


      attr_reader :internal_id
      attr_accessor :external_id, :search_joins

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
