require 'spec_helper'

describe NetSuite::Records::NonInventorySaleItem do
  let(:item) { NetSuite::Records::NonInventorySaleItem.new }

  it 'has the right fields' do
    [
      :available_to_partners, :cost_estimate, :cost_estimate_type, :cost_estimate_units, :country_of_manufacture, :created_date,
      :custom_field_list, :display_name, :dont_show_price, :enforce_min_qty_internally, :exclude_from_sitemap,
      :featured_description, :handling_cost, :handling_cost_units, :include_children, :is_donation_item, :is_fulfillable,
      :is_gco_compliant, :is_inactive, :is_online, :is_taxable, :item_id, :last_modified_date, :manufacturer, :manufacturer_addr1,
      :manufacturer_city, :manufacturer_state, :manufacturer_tariff, :manufacturer_tax_id, :manufacturer_zip, :matrix_option_list,
      :matrix_type, :max_donation_amount, :meta_tag_html, :minimum_quantity, :minimum_quantity_units, :mpn,
      :mult_manufacture_addr, :nex_tag_category, :no_price_message, :offer_support, :on_special, :out_of_stock_behavior,
      :out_of_stock_message, :overall_quantity_pricing_type, :page_title, :preference_criterion, :presentation_item_list,
      :prices_include_tax, :pricing_matrix, :producer, :product_feed_list, :rate, :related_items_description, :sales_description,
      :schedule_b_code, :schedule_b_number, :schedule_b_quantity, :search_keywords, :ship_individually, :shipping_cost,
      :shipping_cost_units, :shopping_dot_com_category, :shopzilla_category_id, :show_default_donation_amount,
      :site_category_list, :sitemap_priority, :soft_descriptor, :specials_description, :stock_description, :store_description,
      :store_detailed_description, :store_display_name, :translations_list, :upc_code, :url_component, :use_marginal_rates,
      :vsoe_deferral, :vsoe_delivered, :vsoe_permit_discount, :vsoe_price, :weight, :weight_unit, :weight_units
    ].each do |field|
      item.should have_field(field)
    end
  end

=begin
  RECORD_REFS

  :income_account
  :tax_schedule
  :units_type
  :sale_unit
  :issue_product
  :billing_schedule
  :deferred_revenue_account
  :rev_rec_schedule
  :ship_package
  :cost_category
  :quantity_pricing_schedule
  :pricing_group
  :store_display_thumbnail
  :store_display_image
  :store_item_template
  :custom_form
  :parent
  :department
  :class
  :location
  :subsidiary_list
  :item_options_list
  :purchase_tax_code
  :sales_tax_code
=end

end
