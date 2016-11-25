require 'spec_helper'

describe NetSuite::Records::KitItem do
  let(:item) { NetSuite::Records::KitItem.new }

  it 'has all the right fields' do
    [
      :available_to_partners, :cost_estimate, :created_date, :defer_rev_rec, :description, :display_name, :dont_show_price, :enforce_min_qty_internally, :exclude_from_sitemap, :featured_description, :handling_cost, :hazmat_hazard_class, :hazmat_id, :hazmat_item_units, :hazmat_item_units_qty, :hazmat_shipping_name, :include_children, :is_donation_item, :is_fulfillable, :is_gco_compliant, :is_hazmat_item, :is_inactive, :is_online, :is_taxable, :item_id, :last_modified_date, :manufacturer, :manufactureraddr1, :manufacturer_city, :manufacturer_state, :manufacturer_tariff, :manufacturer_tax_id, :manufacturer_zip, :max_donation_amount, :meta_tag_html, :minimum_quantity, :mpn, :mult_manufacture_addr, :nex_tag_category, :no_price_message, :offer_support, :on_special, :out_of_stock_message, :page_title, :prices_include_tax, :print_items, :producer, :rate, :related_items_description, :schedule_b_number, :schedule_b_quantity, :search_keywords, :ship_individually, :shipping_cost, :shopping_dot_com_category, :shopzilla_category_id, :show_default_donation_amount, :specials_description, :stock_description, :store_description, :store_detailed_description, :store_display_name, :upc_code, :url_component, :use_marginal_rates, :vsoe_delivered, :vsoe_price, :weight
    ].each do |field|
      expect(item).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :billing_schedule, :custom_form, :default_item_ship_method, :deferred_revenue_account, :department, :income_account, :issue_product, :item_revenue_category, :location, :parent, :pricing_group, :quantity_pricing_schedule, :revenue_allocation_group, :revenue_recognition_rule, :rev_rec_schedule, :sales_tax_code, :schedule_b_code, :ship_package, :soft_descriptor, :store_display_image, :store_display_thumbnail, :store_item_template, :tax_schedule, :weight_unit
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :item_id => "Item100" }) }

      it 'returns a KitItem instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::KitItem, {:external_id => 1}], {}).and_return(response)
        item = NetSuite::Records::KitItem.get(:external_id => 1)
        expect(item).to be_kind_of(NetSuite::Records::KitItem)
        expect(item.item_id).to eql("Item100")
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::KitItem, {:external_id => 1}], {}).and_return(response)
        expect {
          NetSuite::Records::KitItem.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::KitItem with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
    let(:item) { NetSuite::Records::KitItem.new(:item_id => "Item100", :is_inactive => false) }

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
      item.item_id = "Item100"
      item.is_inactive = false
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:itemId'       => "Item100",
        'listAcct:isInactive' => false
      }
      expect(item.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(item.record_type).to eql('listAcct:KitItem')
    end
  end

end
