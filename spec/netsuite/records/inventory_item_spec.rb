require 'spec_helper'

describe NetSuite::Records::InventoryItem do
  let(:item) { NetSuite::Records::InventoryItem.new }

  it 'has all the right fields' do
    [
      :auto_lead_time,
      :auto_preferred_stock_level,
      :auto_reorder_point,
      :available_to_partners,
      :average_cost,
      :backward_consumption_days,
      :contingent_revenue_handling,
      :conversion_rate,
      :copy_description,
      :cost,
      :cost_estimate,
      :cost_estimate_type,
      :cost_estimate_units,
      :costing_method,
      :costing_method_display,
      :cost_units,
      :country_of_manufacture,
      :created_date,
      :currency,
      :date_converted_to_inv,
      :default_return_cost,
      :defer_rev_rec,
      :demand_modifier,
      :demand_time_fence,
      :direct_revenue_posting,
      :display_name,
      :dont_show_price,
      :enable_catch_weight,
      :enforce_min_qty_internally,
      :exclude_from_sitemap,
      :featured_description,
      :fixed_lot_size,
      :forward_consumption_days,
      :fraud_risk,
      :future_horizon,
      :handling_cost,
      :handling_cost_units,
      :hazmat_hazard_class,
      :hazmat_id,
      :hazmat_item_units,
      :hazmat_item_units_qty,
      :hazmat_packing_group,
      :hazmat_shipping_name,
      :include_children,
      :invt_classification,
      :invt_count_interval,
      :is_donation_item,
      :is_drop_ship_item,
      :is_gco_compliant,
      :is_hazmat_item,
      :is_inactive,
      :is_online,
      :is_special_order_item,
      :is_store_pickup_allowed,
      :is_taxable,
      :item_carrier,
      :item_id,
      :last_invt_count_date,
      :last_modified_date,
      :last_purchase_price,
      :lead_time,
      :lower_warning_limit,
      :manufacturer,
      :manufacturer_addr1,
      :manufacturer_city,
      :manufacturer_state,
      :manufacturer_tariff,
      :manufacturer_tax_id,
      :manufacturer_zip,
      :match_bill_to_receipt,
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
      :next_invt_count_date,
      :no_price_message,
      :offer_support,
      :on_hand_value_mli,
      :on_special,
      :original_item_subtype,
      :original_item_type,
      :out_of_stock_behavior,
      :out_of_stock_message,
      :overall_quantity_pricing_type,
      :page_title,
      :periodic_lot_size_days,
      :periodic_lot_size_type,
      :preference_criterion,
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
      :quantity_available_units,
      :quantity_back_ordered,
      :quantity_committed,
      :quantity_committed_units,
      :quantity_on_hand,
      :quantity_on_hand_units,
      :quantity_on_order,
      :quantity_on_order_units,
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
      :ship_individually,
      :shipping_cost,
      :shipping_cost_units,
      :shopping_dot_com_category,
      :shopzilla_category_id,
      :show_default_donation_amount,
      :sitemap_priority,
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
      :upper_warning_limit,
      :url_component,
      :use_bins,
      :use_marginal_rates,
      :vendor_name,
      :vsoe_deferral,
      :vsoe_delivered,
      :vsoe_permit_discount,
      :vsoe_price,
      :vsoe_sop_group,
      :weight,
      :weight_unit,
      :weight_units,
    ].each do |field|
      expect(item).to have_field(field)
    end
  end

  it 'has all the right search_only_fields' do
    [
      :acc_book_rev_rec_forecast_rule, :accounting_book,
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
      :froogle_product_feed, :fx_cost, :generate_accruals, :gift_cert_auth_code,
      :gift_cert_email, :gift_cert_expiration_date, :gift_cert_from,
      :gift_cert_message, :gift_cert_original_amount, :gift_cert_recipient,
      :hierarchy_node, :hierarchy_version, :hits, :image_url,
      :interco_expense_account, :inventory_location, :is_available,
      :is_fulfillable, :is_lot_item, :is_serial_item,
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
      :location_supply_time_fence, :location_supply_type, :location_total_value,
      :loc_backward_consumption_days, :loc_forward_consumption_days,
      :manufacturing_charge_item, :member_item, :member_quantity, :modified,
      :moss_applies, :nextag_product_feed, :num_active_listings,
      :number_allowed_downloads, :num_currently_listed, :obsolete_date,
      :obsolete_revision, :online_customer_price, :online_price, :other_prices,
      :other_vendor, :overhead_type, :preferred_bin, :primary_category,
      :prod_price_variance_acct, :prod_qty_variance_acct,
      :reserve_price,
      :same_as_primary_book_amortization, :same_as_primary_book_rev_rec,
      :scrap_acct, :sell_on_ebay, :serial_number, :serial_number_location,
      :shipping_carrier, :shipping_rate, :shopping_product_feed,
      :shopzilla_product_feed, :starting_price, :subsidiary,
      :sub_type, :thumb_nail_url, :type, :unbuild_variance_account,
      :use_component_yield, :vendor_code, :vendor_cost, :vendor_cost_entered,
      :vendor_price_currency, :vendor_schedule, :vend_return_variance_account,
      :web_site, :wip_acct, :wip_variance_acct, :yahoo_product_feed,
    ].each do |field|
      expect(NetSuite::Records::InventoryItem).to have_search_only_field(field)
    end
  end

  it 'has all the right fields with specific classes' do
    {
      bin_number_list: NetSuite::Records::BinNumberList,
      custom_field_list: NetSuite::Records::CustomFieldList,
      item_ship_method_list: NetSuite::Records::RecordRefList,
      item_vendor_list: NetSuite::Records::ItemVendorList,
      locations_list: NetSuite::Records::LocationsList,
      matrix_option_list: NetSuite::Records::MatrixOptionList,
      pricing_matrix: NetSuite::Records::PricingMatrix,
      subsidiary_list: NetSuite::Records::RecordRefList,
    }.each do |field, klass|
      expect(item).to have_field(field, klass)
    end
  end

  it 'has all the right record refs' do
    [
      :alternate_demand_source_item,
      :asset_account,
      :bill_exch_rate_variance_acct,
      :billing_schedule,
      :bill_price_variance_acct,
      :bill_qty_variance_acct,
      :klass,
      :cogs_account,
      :consumption_unit,
      :cost_category,
      :create_revenue_plans_on,
      :custom_form,
      :default_item_ship_method,
      :deferred_revenue_account,
      :demand_source,
      :department,
      :distribution_category,
      :distribution_network,
      :dropship_expense_account,
      :expense_account,
      :gain_loss_account,
      :income_account,
      :interco_cogs_account,
      :interco_def_rev_account,
      :interco_income_account,
      :issue_product,
      :item_revenue_category,
      :location,
      :parent,
      :planning_item_category,
      :preferred_location,
      :pricing_group,
      :purchase_price_variance_acct,
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
      :secondary_base_unit,
      :secondary_consumption_unit,
      :secondary_purchase_unit,
      :secondary_sale_unit,
      :secondary_stock_unit,
      :secondary_units_type,
      :ship_package,
      :soft_descriptor,
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
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end

  describe '#pricing_matrix' do
    it 'can be set from attributes'
    it 'can be set from a PricingMatrix object'
  end

  describe '#product_feed_list' do
    it 'can be set from attributes'
    it 'can be set from a ProductFeedList object'
  end

  describe '#subsidiary_list' do
    it 'can be set from attributes'
    it 'can be set from a RecordRefList object'
  end

  describe '#item_options_list' do
    it 'can be set from attributes'
    it 'can be set from a ItemOptionsList object'
  end

  describe '#item_vendor_list' do
    it 'can be set from attributes' do
      attributes = {
        :item_vendor => {
          :vendor=>{
            :name=>"Spring Water",
            :"@xmlns:platform_core"=>"urn:core_2016_1.platform.webservices.netsuite.com",
            :@internal_id=>"20"
          },
         :purchase_price=>"16.14",
         :preferred_vendor=>true
        }
      }

      item.item_vendor_list = attributes
      expect(item.item_vendor_list).to be_kind_of(NetSuite::Records::ItemVendorList)
      expect(item.item_vendor_list.item_vendors.length).to eql(1)
    end

    it 'can be set from a ItemVendorList object' do
      item_vendor_list = NetSuite::Records::ItemVendorList.new
      item.item_vendor_list = item_vendor_list
      expect(item.item_vendor_list).to eql(item_vendor_list)
    end
  end

  describe '#site_category_list' do
    it 'can be set from attributes'
    it 'can be set from a SiteCategoryList object'
  end

  describe '#translations_list' do
    it 'can be set from attributes'
    it 'can be set from a TranslationList object'
  end

  describe '#bin_number_list' do
    it 'can be set from attributes'
    it 'can be set from an InventoryItemBinNumberList object'
  end

  describe '#locations_list' do
    let(:response) {
      NetSuite::Response.new(
        :success => true,
        :body => {
          :locations_list => {:locations => %w(loc1 loc2) }
        }
      )
    }

    it 'can be set from attributes'
    it 'can be set from an InventoryItemLocationsList object' do
      expect(NetSuite::Actions::Get).to receive(:call)
        .with([NetSuite::Records::InventoryItem, :internal_id => 20], {})
        .and_return(response)
      item = NetSuite::Records::InventoryItem.get(20)
      expect(item).to be_kind_of(NetSuite::Records::InventoryItem)
      expect(item.locations_list.locations).to eql(%w(loc1 loc2))
    end
  end

  describe '#matrix_option_list' do
    it 'can be set from attributes'
    it 'can be set from a MatrixOptionList object'
  end

  describe '#presentation_item_list' do
    it 'can be set from attributes'
    it 'can be set from a PresentationItemList object'
  end

  describe '#custom_field_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomFieldList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :cost => 100 }) }

      it 'returns a InventoryItem instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::InventoryItem, {:external_id => 1}], {}).and_return(response)
        item = NetSuite::Records::InventoryItem.get(:external_id => 1)
        expect(item).to be_kind_of(NetSuite::Records::InventoryItem)
        expect(item.cost).to eql(100)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::InventoryItem, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::InventoryItem.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::InventoryItem with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:item) { NetSuite::Records::InventoryItem.new(:cost => 100, :is_inactive => false) }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Add).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([item], {}).
            and_return(response)
        expect(item.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      item.cost = 100
      item.is_inactive = false
      item.location_quantity_available = '1.0' # Search only, excluded
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:cost'       => 100,
        'listAcct:isInactive' => false
      }
      expect(item.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(item.record_type).to eql('listAcct:InventoryItem')
    end
  end

  describe '.update_list' do
    before { savon.mock! }
    after { savon.unmock! }

    context 'with one item' do
      before do
        savon.expects(:update_list).with(:message =>
          {
            'record' => [{
              'listAcct:itemId' => 'Target',
              '@xsi:type' => 'listAcct:InventoryItem',
              '@internalId' => '624113'
            }]
        }).returns(File.read('spec/support/fixtures/update_list/update_list_one_item.xml'))
      end

      it 'returns collection with one InventoryItem instances populated with the data from the response object' do
        items = NetSuite::Records::InventoryItem.update_list([
                  NetSuite::Records::InventoryItem.new(internal_id: '624113', item_id: 'Target', upccode: 'Target')
                ])
        shutter_fly = items[0]
        expect(shutter_fly).to be_kind_of(NetSuite::Records::InventoryItem)
        expect(shutter_fly.item_id).to eq('Target')
        expect(shutter_fly.internal_id).to eq('624113')
      end
    end

    context 'with two items' do
      before do
        savon.expects(:update_list).with(:message =>
          {
            'record' => [{
                'listAcct:itemId' => 'Shutter Fly',
                '@xsi:type' => 'listAcct:InventoryItem',
                '@internalId' => '624172'
              },
              {
                'listAcct:itemId' => 'Target',
                '@xsi:type' => 'listAcct:InventoryItem',
                '@internalId' => '624113'
              }
            ]
        }).returns(File.read('spec/support/fixtures/update_list/update_list_items.xml'))
      end

      it 'returns collection of InventoryItem instances populated with the data from the response object' do
        items = NetSuite::Records::InventoryItem.update_list( [
                  NetSuite::Records::InventoryItem.new(internal_id: '624172', item_id: 'Shutter Fly', upccode: 'Shutter Fly, Inc.'),
                  NetSuite::Records::InventoryItem.new(internal_id: '624113', item_id: 'Target', upccode: 'Target')
                ])
        shutter_fly = items[0]
        expect(shutter_fly).to be_kind_of(NetSuite::Records::InventoryItem)
        expect(shutter_fly.item_id).to eq('Shutter Fly')
        expect(shutter_fly.internal_id).to eq('624172')
      end
    end
  end
end
