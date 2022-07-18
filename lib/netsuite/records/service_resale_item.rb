module NetSuite
  module Records
    class ServiceResaleItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_deleted, :get_list, :add, :update, :update_list, :delete, :upsert, :search

      fields :amortization_period,
            :available_to_partners,
            :contingent_revenue_handling,
            :cost,
            :cost_estimate,
            :cost_estimate_type,
            :cost_estimate_units,
            :cost_units,
            :created_date,
            :create_job,
            :currency,
            :defer_rev_rec,
            :direct_revenue_posting,
            :display_name,
            :dont_show_price,
            :enforce_min_qty_internally,
            :exclude_from_sitemap,
            :featured_description,
            :generate_accruals,
            :include_children,
            :is_donation_item,
            :is_fulfillable,
            :is_gco_compliant,
            :is_inactive,
            :is_online,
            :is_taxable,
            :item_id,
            :last_modified_date,
            :manufacturing_charge_item,
            :matrix_item_name_template,
            :matrix_type,
            :max_donation_amount,
            :maximum_quantity,
            :meta_tag_html,
            :minimum_quantity,
            :minimum_quantity_units,
            :no_price_message,
            :offer_support,
            :on_special,
            :out_of_stock_behavior,
            :out_of_stock_message,
            :overall_quantity_pricing_type,
            :page_title,
            :prices_include_tax,
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
            :search_keywords,
            :show_default_donation_amount,
            :sitemap_priority,
            :soft_descriptor,
            :specials_description,
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
            :vsoe_sop_group

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
                  :deferral_account,
                  :deferred_revenue_account,
                  :department,
                  :expense_account,
                  :income_account,
                  :interco_def_rev_account,
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
                  :rev_reclass_f_x_account,
                  :rev_rec_schedule,
                  :sales_tax_code,
                  :sale_unit,
                  :store_display_image,
                  :store_display_thumbnail,
                  :store_item_template,
                  :tax_schedule,
                  :units_type,
                  :vendor

      field :custom_field_list, CustomFieldList
      field :item_vendor_list, ItemVendorList
      field :matrix_option_list, MatrixOptionList
      field :pricing_matrix, PricingMatrix
      field :subsidiary_list, RecordRefList
      # TODO: field :accounting_book_detail_list, ItemAccountingBookDetailList
      # TODO: field :billing_rates_matrix, BillingRatesMatrix
      # TODO: field :item_options_list, ItemOptionsList
      # TODO: field :item_task_templates_list, ServiceItemTaskTemplatesList
      # TODO: field :hierarchy_versions_list, ServiceResaleItemHierarchyVersionsList
      # TODO: field :presentation_item_list, PresentationItemList
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
