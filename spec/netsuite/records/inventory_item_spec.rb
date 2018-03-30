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
      expect(item).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :alternate_demand_source_item, :asset_account, :bill_exch_rate_variance_acct, :bill_price_variance_acct, :bill_qty_variance_acct, :billing_schedule, :cogs_account, :cost_category, :custom_form, :deferred_revenue_account, :demand_source, :department, :expense_account, :gain_loss_account, :income_account, :issue_product, :klass, :location, :parent, :preferred_location, :pricing_group, :purchase_price_variance_acct, :purchase_tax_code, :purchase_unit, :quantity_pricing_schedule, :rev_rec_schedule, :sale_unit, :sales_tax_code, :ship_package, :soft_descriptor, :stock_unit, :store_display_image, :store_display_thumbnail, :store_item_template, :supply_lot_sizing_method, :supply_replenishment_method, :supply_type, :tax_schedule, :units_type, :vendor
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
