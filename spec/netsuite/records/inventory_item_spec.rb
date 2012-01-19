require 'spec_helper'

describe NetSuite::Records::InventoryItem do
  let(:item) { NetSuite::Records::InventoryItem.new }

  it 'has all the right fields' do
    [
      :auto_lead_time, :auto_preferred_stock_level, :auto_reorder_point, :available_to_partners, :average_cost, :copy_description,
      :cost, :cost_estimate, :cost_estimate_type, :cost_estimate_units, :cost_units, :costing_method, :costing_method_display,
      :country_of_manufacture, :created_date, :currency, :date_converted_to_inv, :default_return_cost, :demand_modifier,
      :display_name, :dont_show_price, :enforce_min_qty_internally, :exclude_from_sitemap, :featured_description, :fixed_lot_size,
      :handling_cost, :handling_cost_units, :include_children, :is_donation_item, :is_drop_ship_item, :is_gco_compliant,
      :is_inactive, :is_online, :is_special_order_item, :is_taxable, :item_id, :last_modified_date, :last_purchase_price,
      :lead_time, :manufacturer, :manufacturer_addr1, :manufacturer_city, :manufacturer_state, :manufacturer_tariff,
      :manufacturer_tax_id, :manufacturer_zip, :match_bill_to_receipt, :matrix_type, :max_donation_amount, :meta_tag_html,
      :minimum_quantity, :minimum_quantity_units, :mpn, :mult_manufacture_addr, :nex_tag_category, :no_price_message,
      :offer_support, :on_hand_value_mli, :on_special, :original_item_subtype, :original_item_type, :out_of_stock_behavior,
      :out_of_stock_message, :overall_quantity_pricing_type, :page_title, :preference_criterion, :preferred_stock_level,
      :preferred_stock_level_days, :preferred_stock_level_units, :prices_include_tax, :producer, :purchase_description,
      :quantity_available, :quantity_available_units, :quantity_back_ordered, :quantity_committed, :quantity_committed_units,
      :quantity_on_hand, :quantity_on_hand_units, :quantity_on_order, :quantity_on_order_units, :quantity_reorder_units, :rate,
      :related_items_description, :reorder_multiple, :reorder_point, :reorder_point_units, :safety_stock_level,
      :safety_stock_level_days, :safety_stock_level_units, :sales_description, :schedule_b_code, :schedule_b_number,
      :schedule_b_quantity, :search_keywords, :seasonal_demand, :ship_individually, :shipping_cost, :shipping_cost_units,
      :shopping_dot_com_category, :shopzilla_category_id, :show_default_donation_amount, :sitemap_priority, :specials_description,
      :stock_description, :store_description, :store_detailed_description, :store_display_name, :total_value, :track_landed_cost,
      :transfer_price, :upc_code, :url_component, :use_bins, :use_marginal_rates, :vendor_name, :vsoe_deferral, :vsoe_delivered,
      :vsoe_permit_discount, :vsoe_price, :weight, :weight_unit, :weight_units
    ].each do |field|
      item.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :alternate_demand_source_item, :asset_account, :bill_exch_rate_variance_acct, :bill_price_variance_acct, :bill_qty_variance_acct, :billing_schedule, :cogs_account, :cost_category, :custom_form, :deferred_revenue_account, :demand_source, :department, :expense_account, :gain_loss_account, :income_account, :issue_product, :klass, :location, :parent, :preferred_location, :pricing_group, :purchase_price_variance_acct, :purchase_tax_code, :purchase_unit, :quantity_pricing_schedule, :rev_rec_schedule, :sale_unit, :sales_tax_code, :ship_package, :soft_descriptor, :stock_unit, :store_display_image, :store_display_thumbnail, :store_item_template, :supply_lot_sizing_method, :supply_replenishment_method, :supply_type, :tax_schedule, :units_type, :vendor
    ].each do |record_ref|
      item.should have_record_ref(record_ref)
    end
  end

# <element name="pricingMatrix" type="listAcct:PricingMatrix" minOccurs="0"/>
# <element name="productFeedList" type="listAcct:ProductFeedList" minOccurs="0"/>
# <element name="subsidiaryList" type="platformCore:RecordRefList" minOccurs="0"/>
# <element name="itemOptionsList" type="listAcct:ItemOptionsList" minOccurs="0"/>
# <element name="itemVendorList" type="listAcct:ItemVendorList" minOccurs="0"/>
# <element name="siteCategoryList" type="listAcct:SiteCategoryList" minOccurs="0"/>
# <element name="translationsList" type="listAcct:TranslationList" minOccurs="0"/>
# <element name="binNumberList" type="listAcct:InventoryItemBinNumberList" minOccurs="0"/>
# <element name="locationsList" type="listAcct:InventoryItemLocationsList" minOccurs="0"/>
# <element name="matrixOptionList" type="listAcct:MatrixOptionList" minOccurs="0"/>
# <element name="presentationItemList" type="listAcct:PresentationItemList" minOccurs="0"/>
# <element name="customFieldList" type="platformCore:CustomFieldList" minOccurs="0"/>

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :cost => 100 }) }

      it 'returns a InventoryItem instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::InventoryItem, :external_id => 1).and_return(response)
        item = NetSuite::Records::InventoryItem.get(:external_id => 1)
        item.should be_kind_of(NetSuite::Records::InventoryItem)
        item.cost.should eql(100)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::InventoryItem, :external_id => 1).and_return(response)
        lambda {
          NetSuite::Records::InventoryItem.get(:external_id => 1)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::InventoryItem with OPTIONS=(.*) could not be found/)
      end
    end
  end

end
