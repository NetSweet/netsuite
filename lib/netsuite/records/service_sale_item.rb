module NetSuite
  module Records
    class ServiceSaleItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_deleted, :get_list, :add, :update, :update_list, :delete, :upsert, :search

      fields :available_to_partners, :cost_estimate, :cost_estimate_type, :cost_estimate_units, :create_job, :created_date,
        :display_name, :dont_show_price, :enforce_min_qty_internally, :exclude_from_sitemap, :featured_description,
        :include_children, :is_donation_item, :is_fulfillable, :is_gco_compliant, :is_inactive, :is_online, :is_taxable,
        :item_id, :last_modified_date, :matrix_option_list, :matrix_type, :max_donation_amount, :meta_tag_html,
        :minimum_quantity, :minimum_quantity_units, :no_price_message, :offer_support, :on_special, :out_of_stock_behavior,
        :out_of_stock_message, :overall_quantity_pricing_type, :page_title, :presentation_item_list, :prices_include_tax,
        :rate, :related_items_description, :sales_description, :search_keywords,
        :show_default_donation_amount, :site_category_list, :sitemap_priority, :soft_descriptor, :specials_description,
        :store_description, :store_detailed_description, :store_display_name, :translations_list, :upc_code, :url_component,
        :use_marginal_rates, :vsoe_deferral, :vsoe_delivered, :vsoe_permit_discount, :vsoe_price, :vsoe_sop_group

      # item_task_templates_list
      # billing_rates_matrix -- RecordRef, via listAcct::ItemOptionsList

      record_refs :billing_schedule, :cost_category, :custom_form, :deferred_revenue_account, :department, :income_account,
        :issue_product, :item_options_list, :klass, :location, :parent, :pricing_group, :purchase_tax_code,
        :quantity_pricing_schedule, :rev_rec_schedule, :sale_unit, :sales_tax_code, :store_display_image,
        :store_display_thumbnail, :store_item_template, :tax_schedule, :units_type, :revenue_recognition_rule

      field :pricing_matrix, PricingMatrix
      field :custom_field_list, CustomFieldList
      field :subsidiary_list, RecordRefList

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
