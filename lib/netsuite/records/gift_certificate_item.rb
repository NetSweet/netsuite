module NetSuite
  module Records
    class GiftCertificateItem
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ListAcct

      actions :get, :get_list, :add, :delete, :search, :update_list, :upsert

      fields :auth_codes_list,
        :available_to_partners,
        :billing_schedule,
        :cost_estimate,
        :cost_estimate_type,
        :created_date,
        :days_before_expiration,
        :display_name,
        :dont_show_price,
        :exclude_from_sitemap,
        :featured_description,
        :include_children,
        :is_donation_item,
        :is_fulfillable,
        :is_gco_compliant,
        :is_inactive,
        :is_online,
        :is_taxable,
        :item_id,
        :item_options_list,
        :last_modified_date,
        :liability_account,
        :max_donation_amount,
        :meta_tag_html,
        :no_price_message,
        :offer_support,
        :on_special,
        :out_of_stock_behavior,
        :out_of_stock_message,
        :page_title,
        :presentation_item_list,
        :prices_include_tax,
        :pricing_matrix,
        :rate,
        :related_items_description,
        :sales_description,
        :search_keywords,
        :show_default_donation_amount,
        :site_category_list,
        :sitemap_priority,
        :specials_description,
        :store_description,
        :store_detailed_description,
        :store_display_image,
        :store_display_name,
        :store_display_thumbnail,
        :store_item_template,
        :subsidiary_list,
        :translations_list,
        :upc_code,
        :url_component

      field :custom_field_list, CustomFieldList

      record_refs :klass, :custom_form, :department, :income_account,
                  :issue_product, :location, :parent, :sales_tax_code, :tax_schedule

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
