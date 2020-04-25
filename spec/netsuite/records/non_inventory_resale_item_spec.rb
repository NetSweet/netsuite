require 'spec_helper'

describe NetSuite::Records::NonInventoryResaleItem do
  let(:item) { NetSuite::Records::NonInventoryResaleItem.new }

  it 'has the right fields' do
    [
      :available_to_partners, :cost_estimate, :cost_estimate_type, :cost_estimate_units, :country_of_manufacture, :created_date,
      :display_name, :dont_show_price, :enforce_min_qty_internally, :exclude_from_sitemap,
      :featured_description, :handling_cost, :handling_cost_units, :include_children, :is_donation_item, :is_fulfillable,
      :is_gco_compliant, :is_inactive, :is_online, :is_taxable, :item_id, :last_modified_date, :manufacturer, :manufacturer_addr1,
      :manufacturer_city, :manufacturer_state, :manufacturer_tariff, :manufacturer_tax_id, :manufacturer_zip, :matrix_option_list,
      :matrix_type, :max_donation_amount, :meta_tag_html, :minimum_quantity, :minimum_quantity_units, :mpn,
      :mult_manufacture_addr, :nex_tag_category, :no_price_message, :offer_support, :on_special, :out_of_stock_behavior,
      :out_of_stock_message, :overall_quantity_pricing_type, :page_title, :preference_criterion, :presentation_item_list,
      :prices_include_tax, :producer, :product_feed_list, :rate, :related_items_description, :sales_description,
      :schedule_b_code, :schedule_b_number, :schedule_b_quantity, :search_keywords, :ship_individually, :shipping_cost,
      :shipping_cost_units, :shopping_dot_com_category, :shopzilla_category_id, :show_default_donation_amount,
      :site_category_list, :sitemap_priority, :soft_descriptor, :specials_description, :stock_description, :store_description,
      :store_detailed_description, :store_display_name, :translations_list, :upc_code, :url_component, :use_marginal_rates,
      :vsoe_deferral, :vsoe_delivered, :vsoe_permit_discount, :vsoe_price, :weight, :weight_unit, :weight_units
    ].each do |field|
      expect(item).to have_field(field)
    end

    # TODO there is a probably a more robust way to test this
    expect(item.custom_field_list.class).to eq(NetSuite::Records::CustomFieldList)
    expect(item.pricing_matrix.class).to eq(NetSuite::Records::PricingMatrix)
    expect(item.subsidiary_list.class).to eq(NetSuite::Records::RecordRefList)
    expect(item.item_vendor_list.class).to eq(NetSuite::Records::ItemVendorList)

  end

  it 'has the right record_refs' do
    [
        :billing_schedule, :cost_category, :custom_form, :deferred_revenue_account, :department, :income_account,
        :issue_product, :item_options_list, :klass, :location, :parent, :pricing_group, :purchase_tax_code,
        :quantity_pricing_schedule, :rev_rec_schedule, :sale_unit, :sales_tax_code, :ship_package, :store_display_image,
        :store_display_thumbnail, :store_item_template, :tax_schedule, :units_type, :expense_account
    ].each do |record_ref|
      expect(item).to have_record_ref(record_ref)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :manufacturer_zip => '90401' }) }

      it 'returns a NonInventoryResaleItem instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::NonInventoryResaleItem, {:external_id => 20}], {}).and_return(response)
        customer = NetSuite::Records::NonInventoryResaleItem.get(:external_id => 20)
        expect(customer).to be_kind_of(NetSuite::Records::NonInventoryResaleItem)
        expect(customer.manufacturer_zip).to eql('90401')
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::NonInventoryResaleItem, {:external_id => 20}], {}).and_return(response)
        expect {
          NetSuite::Records::NonInventoryResaleItem.get(:external_id => 20)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::NonInventoryResaleItem with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '#add' do
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

  describe '#update' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        expect(NetSuite::Actions::Update).to receive(:call).
            with([item.class, {external_id: 'foo'}], {}).
            and_return(response)
        item.external_id = 'foo'
        expect(item.update).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        expect(NetSuite::Actions::Update).to receive(:call).
            with([item.class, {external_id: 'foo'}], {}).
            and_return(response)
        item.external_id = 'foo'
        expect(item.update).to be_falsey
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
      item.handling_cost = 100.0
      item.is_online     = true
    end

    it 'can represent itself as a SOAP record' do
      record = {
        'listAcct:handlingCost' => 100.0,
        'listAcct:isOnline'     => true
      }
      expect(item.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string of the SOAP type' do
      expect(item.record_type).to eql('listAcct:NonInventoryResaleItem')
    end
  end

end
