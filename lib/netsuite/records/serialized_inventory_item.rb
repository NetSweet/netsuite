module NetSuite
  module Records
    class SerializedInventoryItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_deleted, :get_list, :add, :delete, :search, :update, :update_list, :upsert

      record_refs :soft_descriptor,
        :stock_unit,
        :store_display_image,
        :store_display_thumbnail,
        :store_item_template,
        :supply_lot_sizing_method,
        :supply_replenishment_method,
        :supply_type,
        :tax_schedule,
        :units_type,
        :vendor,
        :alternate_demand_source_item,
        :asset_account,
        :bill_exch_rate_variance_acct,
        :billing_schedule,
        :bill_price_variance_acct,
        :bill_qty_variance_acct,
        :klass,
        :cogs_account,
        :cost_category,
        :custom_form,
        :deferred_revenue_account,
        :demand_source,
        :department,
        :dropship_expense_account,
        :gain_loss_account,
        :income_account,
        :interco_cogs_account,
        :interco_income_account,
        :issue_product,
        :location,
        :parent,
        :preferred_location,
        :pricing_group,
        :purchase_price_variance_acct,
        :purchase_tax_code,
        :purchase_unit,
        :quantity_pricing_schedule,
        :sales_tax_code,
        :sale_unit,
        :ship_package,
        :revenue_allocation_group,
        :revenue_recognition_rule,
        :rev_rec_schedule

      # bin_number_list	InventoryItemBinNumberList
      # custom_field_list	CustomFieldList
      # hazmat_packing_group	HazmatPackingGroup
      # invt_classification	ItemInvtClassification
      # item_carrier	ItemCarrier
      # item_number_options_list	RecordRefList
      # item_options_list	ItemOptionsList
      # item_revenue_category	RecordRef
      # item_ship_method_list	RecordRefList
      # item_vendor_list	ItemVendorList
      # locations_list	SerializedInventoryItemLocationsList
      # matrix_option_list	MatrixOptionList
      # matrix_type	ItemMatrixType
      # out_of_stock_behavior	ItemOutOfStockBehavior
      # overall_quantity_pricing_type	ItemOverallQuantityPricingType
      # periodic_lot_size_type	PeriodicLotSizeType
      # preference_criterion	ItemPreferenceCriterion
      # presentation_item_list	PresentationItemList
      # pricing_matrix	PricingMatrix
      # product_feed_list	ProductFeedList
      # accounting_book_detail_list	ItemAccountingBookDetailList

      fields :auto_lead_time,
        :auto_preferred_stock_level,
        :auto_reorder_point,
        :available_to_partners,
        :average_cost,
        :backward_consumption_days,
        :copy_description,
        :cost,
        :cost_estimate,
        :costing_method_display,
        :cost_units,
        :created_date,
        :currency,
        :default_item_ship_method,
        :default_return_cost,
        :demand_modifier,
        :demand_time_fence,
        :display_name,
        :dont_show_price,
        :enforce_min_qty_internally,
        :exclude_from_sitemap,
        :featured_description,
        :fixed_lot_size,
        :forward_consumption_days,
        :handling_cost,
        :handling_cost_units,
        :hazmat_hazard_class,
        :hazmat_id,
        :hazmat_item_units,
        :hazmat_item_units_qty,
        :hazmat_shipping_name,
        :include_children,
        :invt_count_interval,
        :is_donation_item,
        :is_drop_ship_item,
        :is_gco_compliant,
        :is_hazmat_item,
        :is_inactive,
        :is_online,
        :is_special_order_item,
        :is_taxable,
        :item_id,
        :last_invt_count_date,
        :last_modified_date,
        :last_purchase_price,
        :lead_time,
        :manufacturer,
        :manufacturer_addr1,
        :manufacturer_city,
        :manufacturer_state,
        :manufacturer_tariff,
        :manufacturer_tax_id,
        :manufacturer_zip,
        :match_bill_to_receipt,
        :max_donation_amount,
        :meta_tag_html,
        :minimum_quantity,
        :minimum_quantity_units,
        :mpn,
        :mult_manufacture_addr,
        :nex_tag_category,
        :next_invt_count_date,
        :no_price_message,
        :offer_support,
        :on_hand_value_mli,
        :on_special,
        :out_of_stock_message,
        :page_title,
        :periodic_lot_size_days,
        :preferred_stock_level,
        :preferred_stock_level_days,
        :preferred_stock_level_units,
        :prices_include_tax,
        :producer,
        :purchase_description,
        :purchase_order_amount,
        :purchase_order_quantity,
        :purchase_order_quantity_diff,
        :quantity_available,
        :quantity_back_ordered,
        :quantity_committed,
        :quantity_on_hand,
        :quantity_on_hand_units,
        :quantity_on_order,
        :quantity_reorder_units,
        :rate,
        :receipt_amount,
        :receipt_quantity,
        :receipt_quantity_diff,
        :related_items_description,
        :reorder_multiple,
        :reorder_point,
        :reorder_point_units,
        :reschedule_in_days,
        :reschedule_out_days,
        :round_up_as_component,
        :safety_stock_level,
        :safety_stock_level_days,
        :safety_stock_level_units,
        :sales_description,
        :schedule_b_code,
        :schedule_b_number,
        :schedule_b_quantity,
        :search_keywords,
        :seasonal_demand,
        :serial_numbers,
        :ship_individually,
        :shipping_cost,
        :shipping_cost_units,
        :shopping_dot_com_category,
        :shopzilla_category_id,
        :show_default_donation_amount,
        :specials_description,
        :stock_description,
        :store_description,
        :store_detailed_description,
        :store_display_name,
        :supply_time_fence,
        :total_value,
        :track_landed_cost,
        :transfer_price,
        :upc_code,
        :url_component,
        :use_bins,
        :use_marginal_rates,
        :vendor_name,
        :vsoe_delivered,
        :vsoe_price,
        :weight,
        :weight_units

      # cost_estimate_type	ItemCostEstimateType
      # costing_method	ItemCostingMethod
      # country_of_manufacture	Country
      # create_revenue_plans_on	ItemCreateRevenuePlansOn
      # site_category_list	SiteCategoryList
      # sitemap_priority	SitemapPriority
      # subsidiary_list	RecordRefList
      field :translations_list, TranslationList
      # vsoe_deferral	VsoeDeferral
      # vsoe_permit_discount	VsoePermitDiscount
      # vsoe_sop_group	VsoeSopGroup
      # weight_unit	ItemWeightUnit

      field :custom_field_list, CustomFieldList
      field :locations_list, SerializedInventoryItemLocationsList
      field :subsidiary_list, RecordRefList
      field :numbers_list, SerializedInventoryItemNumbersList

      # TODO from standard copied item record; may need to be deleted
      # field :pricing_matrix, PricingMatrix
      # field :bin_number_list, BinNumberList
      # field :item_vendor_list, ItemVendorList
      # field :matrix_option_list, MatrixOptionList

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
