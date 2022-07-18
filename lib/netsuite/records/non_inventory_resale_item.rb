module NetSuite
  module Records
    class NonInventoryResaleItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_deleted, :get_list, :add, :delete, :search, :upsert, :update, :update_list

      fields :amortization_period,
            :available_to_partners,
            :copy_description,
            :cost,
            :cost_estimate,
            :cost_estimate_type,
            :cost_estimate_units,
            :cost_units,
            :country_of_manufacture,
            :created_date,
            :currency,
            :defer_rev_rec,
            :direct_revenue_posting,
            :display_name,
            :dont_show_price,
            :enforce_min_qty_internally,
            :exclude_from_sitemap,
            :featured_description,
            :generate_accruals,
            :handling_cost,
            :handling_cost_units,
            :hazmat_hazard_class,
            :hazmat_id,
            :hazmat_item_units,
            :hazmat_item_units_qty,
            :hazmat_packing_group,
            :hazmat_shipping_name,
            :include_children,
            :is_donation_item,
            :is_drop_ship_item,
            :is_fulfillable,
            :is_gco_compliant,
            :is_hazmat_item,
            :is_inactive,
            :is_online,
            :is_special_order_item,
            :is_taxable,
            :item_carrier,
            :item_id,
            :last_modified_date,
            :manufacturer,
            :manufacturer_addr1,
            :manufacturer_city,
            :manufacturer_state,
            :manufacturer_tariff,
            :manufacturer_tax_id,
            :manufacturer_zip,
            :matrix_item_name_template,
            :matrix_type,
            :max_donation_amount,
            :maximum_quantity,
            :meta_tag_html,
            :minimum_quantity,
            :minimum_quantity_units,
            :mpn,
            :mult_manufacture_addr,
            :nex_tag_category,
            :no_price_message,
            :offer_support,
            :on_special,
            :out_of_stock_behavior,
            :out_of_stock_message,
            :overall_quantity_pricing_type,
            :page_title,
            :preference_criterion,
            :prices_include_tax,
            :producer,
            :purchase_description,
            :purchase_order_amount,
            :purchase_order_quantity,
            :purchase_order_quantity_diff,
            :rate,
            :receipt_amount,
            :receipt_quantity,
            :receipt_quantity_diff,
            :related_items_description,
            :residual,
            :sales_description,
            :schedule_b_code,
            :schedule_b_number,
            :schedule_b_quantity,
            :search_keywords,
            :ship_individually,
            :shipping_cost,
            :shipping_cost_units,
            :shopping_dot_com_category,
            :shopzilla_category_id,
            :show_default_donation_amount,
            :sitemap_priority,
            :soft_descriptor,
            :specials_description,
            :stock_description,
            :store_description,
            :store_detailed_description,
            :store_display_name,
            :upc_code,
            :url_component,
            :use_marginal_rates,
            :vendor_name,
            :vsoe_deferral,
            :vsoe_delivered,
            :vsoe_permit_discount,
            :vsoe_price,
            :vsoe_sop_group,
            :weight,
            :weight_unit,
            :weight_units

      record_refs :amortization_template,
                  :bill_exch_rate_variance_acct,
                  :billing_schedule,
                  :bill_price_variance_acct,
                  :bill_qty_variance_acct,
                  :klass,
                  :consumption_unit,
                  :cost_category,
                  :create_revenue_plans_on,
                  :custom_form,
                  :default_item_ship_method,
                  :deferral_account,
                  :deferred_revenue_account,
                  :department,
                  :dropship_expense_account,
                  :expense_account,
                  :income_account,
                  :interco_expense_account,
                  :interco_income_account,
                  :issue_product,
                  :item_revenue_category,
                  :location,
                  :parent,
                  :pricing_group,
                  :purchase_tax_code,
                  :purchase_unit,
                  :quantity_pricing_schedule,
                  :revenue_allocation_group,
                  :revenue_recognition_rule,
                  :rev_rec_forecast_rule,
                  :rev_rec_schedule,
                  :sales_tax_code,
                  :sale_unit,
                  :ship_package,
                  :store_display_image,
                  :store_display_thumbnail,
                  :store_item_template,
                  :tax_schedule,
                  :units_type,
                  :vendor

      field :custom_field_list, CustomFieldList
      field :item_ship_method_list, RecordRefList
      field :matrix_option_list, MatrixOptionList
      field :pricing_matrix, PricingMatrix
      field :subsidiary_list, RecordRefList
      field :item_vendor_list, ItemVendorList
      # TODO: field :accounting_book_detail_list, ItemAccountingBookDetailList
      # TODO: field :hierarchy_versions_list, NonInventoryResaleItemHierarchyVersionsList
      # TODO: field :item_options_list, ItemOptionsList
      # TODO: field :presentation_item_list, PresentationItemList
      # TODO: field :product_feed_list, ProductFeedList
      # TODO: field :site_category_list, SiteCategoryList
      field :translations_list, TranslationList

      attr_reader   :internal_id
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
