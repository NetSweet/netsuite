module NetSuite
  module Records
    class InventoryItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      # NOTE NetSuite doesn't have a InventoryItemSearch object. So we use
      # the ItemSearch instead. In order to actually get Inventory Items only
      # you will still have to specify the type:
      #
      #   basic: [
      #     {
      #       field: 'type',
      #       operator: 'anyOf',
      #       type: 'SearchEnumMultiSelectField',
      #       value: ['_inventoryItem']
      #     }
      #  ]
      #
      actions :get, :get_list, :add, :delete, :search, :update, :upsert, :update_list

      fields :auto_lead_time, :auto_preferred_stock_level, :auto_reorder_point, :available_to_partners, :average_cost,
        :copy_description, :cost, :cost_estimate, :cost_estimate_type, :cost_estimate_units, :cost_units, :costing_method,
        :costing_method_display, :country_of_manufacture, :created_date, :currency, :date_converted_to_inv,
        :default_return_cost, :demand_modifier, :display_name, :dont_show_price, :enforce_min_qty_internally,
        :exclude_from_sitemap, :featured_description, :fixed_lot_size, :handling_cost, :handling_cost_units, :include_children,
        :is_donation_item, :is_drop_ship_item, :is_gco_compliant, :is_inactive, :is_online, :is_special_order_item, :is_taxable,
        :item_id, :last_modified_date, :last_purchase_price, :lead_time, :manufacturer, :manufacturer_addr1, :manufacturer_city,
        :manufacturer_state, :manufacturer_tariff, :manufacturer_tax_id, :manufacturer_zip, :match_bill_to_receipt,
        :matrix_type, :max_donation_amount, :meta_tag_html, :minimum_quantity, :minimum_quantity_units, :mpn,
        :mult_manufacture_addr, :nex_tag_category, :no_price_message, :offer_support, :on_hand_value_mli, :on_special,
        :original_item_subtype, :original_item_type, :out_of_stock_behavior, :out_of_stock_message,
        :overall_quantity_pricing_type, :page_title, :preference_criterion, :preferred_stock_level, :preferred_stock_level_days,
        :preferred_stock_level_units, :prices_include_tax, :producer, :purchase_description, :quantity_available,
        :quantity_available_units, :quantity_back_ordered, :quantity_committed, :quantity_committed_units, :quantity_on_hand,
        :quantity_on_hand_units, :quantity_on_order, :quantity_on_order_units, :quantity_reorder_units, :rate,
        :related_items_description, :reorder_multiple, :reorder_point, :reorder_point_units, :safety_stock_level,
        :safety_stock_level_days, :safety_stock_level_units, :sales_description, :schedule_b_code, :schedule_b_number,
        :schedule_b_quantity, :search_keywords, :seasonal_demand, :ship_individually, :shipping_cost, :shipping_cost_units,
        :shopping_dot_com_category, :shopzilla_category_id, :show_default_donation_amount, :sitemap_priority,
        :specials_description, :stock_description, :store_description, :store_detailed_description, :store_display_name,
        :total_value, :track_landed_cost, :transfer_price, :upc_code, :url_component, :use_bins, :use_marginal_rates,
        :vendor_name, :vsoe_deferral, :vsoe_delivered, :vsoe_permit_discount, :vsoe_price, :weight, :weight_unit, :weight_units

      # https://system.netsuite.com/help/helpcenter/en_US/srbrowser/Browser2020_2/schema/search/itemsearchrowbasic.html?mode=package
      search_only_fields :acc_book_rev_rec_forecast_rule, :accounting_book,
        :accounting_book_amortization, :accounting_book_create_plans_on,
        :accounting_book_rev_rec_rule, :accounting_book_rev_rec_schedule,
        :allowed_shipping_method, :atp_lead_time, :atp_method, :base_price,
        :bin_number, :bin_on_hand_avail, :bin_on_hand_count, :bom_quantity,
        :build_entire_assembly, :build_time, :buy_it_now_price, :category,
        :category_preferred, :component_yield, :correlated_item,
        :correlated_item_correlation, :correlated_item_count,
        :correlated_item_lift, :correlated_item_purchase_rate,
        :cost_accounting_status, :created, :create_job,
        :cust_return_variance_account, :date_viewed, :days_before_expiration,
        :default_shipping_method, :deferred_expense_account,
        :departmentnohierarchy, :display_ine_bay_store, :e_bay_item_description,
        :e_bay_item_subtitle, :e_bay_item_title, :ebay_relisting_option,
        :effective_bom_control, :effective_date, :effective_revision,
        :end_auctions_when_out_of_stock, :feed_description, :feed_name,
        :froogle_product_feed, :fx_cost, :generate_accruals,
        :gift_cert_auth_code, :gift_cert_email, :gift_cert_expiration_date,
        :gift_cert_from, :gift_cert_message, :gift_cert_original_amount,
        :gift_cert_recipient, :hierarchy_node, :hierarchy_version, :hits,
        :image_url, :interco_expense_account, :inventory_location,
        :is_available, :is_fulfillable, :is_lot_item, :is_serial_item,
        :is_special_work_order_item, :is_vsoe_bundle, :is_wip, :item_url,
        :last_quantity_available_change, :liability_account, :listing_duration,
        :location_allow_store_pickup, :location_atp_lead_time,
        :location_average_cost, :location_bin_quantity_available,
        :location_build_time, :location_cost, :location_cost_accounting_status,
        :location_default_return_cost, :location_demand_source,
        :location_demand_time_fence, :location_fixed_lot_size,
        :location_inventory_cost_template, :location_invt_classification,
        :location_invt_count_interval, :location_last_invt_count_date,
        :location_lead_time, :location_next_invt_count_date,
        :location_periodic_lot_size_days, :location_periodic_lot_size_type,
        :location_preferred_stock_level, :location_qty_avail_for_store_pickup,
        :location_quantity_available, :location_quantity_back_ordered,
        :location_quantity_committed, :location_quantity_in_transit,
        :location_quantity_on_hand, :location_quantity_on_order,
        :location_re_order_point, :location_reschedule_in_days,
        :location_reschedule_out_days, :location_safety_stock_level,
        :location_store_pickup_buffer_stock, :location_supply_lot_sizing_method,
        :location_supply_time_fence, :location_supply_type,
        :location_total_value, :loc_backward_consumption_days,
        :loc_forward_consumption_days, :manufacturing_charge_item, :member_item,
        :member_quantity, :modified, :moss_applies, :nextag_product_feed,
        :num_active_listings, :number_allowed_downloads, :num_currently_listed,
        :obsolete_date, :obsolete_revision, :online_customer_price,
        :online_price, :other_prices, :other_vendor, :overhead_type,
        :preferred_bin, :primary_category, :prod_price_variance_acct,
        :prod_qty_variance_acct, :reserve_price,
        :same_as_primary_book_amortization,
        :same_as_primary_book_rev_rec, :scrap_acct, :sell_on_ebay,
        :serial_number, :serial_number_location, :shipping_carrier,
        :shipping_rate, :shopping_product_feed, :shopzilla_product_feed,
        :starting_price, :subsidiary, :sub_type,
        :thumb_nail_url, :type, :unbuild_variance_account, :use_component_yield,
        :vendor_code, :vendor_cost, :vendor_cost_entered,
        :vendor_price_currency, :vendor_schedule, :vend_return_variance_account,
        :web_site, :wip_acct, :wip_variance_acct, :yahoo_product_feed

      record_refs :alternate_demand_source_item, :asset_account, :bill_exch_rate_variance_acct, :bill_price_variance_acct,
        :bill_qty_variance_acct, :billing_schedule, :cogs_account, :cost_category, :custom_form, :deferred_revenue_account,
        :demand_source, :department, :expense_account, :gain_loss_account, :income_account, :issue_product, :klass, :location,
        :parent, :preferred_location, :pricing_group, :purchase_price_variance_acct, :purchase_tax_code, :purchase_unit,
        :quantity_pricing_schedule, :rev_rec_schedule, :sale_unit, :sales_tax_code, :ship_package, :soft_descriptor,
        :stock_unit, :store_display_image, :store_display_thumbnail, :store_item_template, :supply_lot_sizing_method,
        :supply_replenishment_method, :supply_type, :tax_schedule, :units_type, :vendor, :create_revenue_plans_on,
        :revenue_recognition_rule, :rev_rec_forecast_rule

      field :pricing_matrix, PricingMatrix
      field :custom_field_list, CustomFieldList
      field :bin_number_list, BinNumberList
      field :locations_list, LocationsList
      field :item_vendor_list, ItemVendorList
      field :matrix_option_list, MatrixOptionList
      field :subsidiary_list, RecordRefList

      # for Assembly/Kit
      field :member_list, MemberList

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
