require 'spec_helper'

describe NetSuite::Records::Estimate do
  let(:estimate) { NetSuite::Records::Estimate.new }
  let(:customer) { NetSuite::Records::Customer.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

  it 'has all the right fields' do
    [
      :alt_handling_cost,
      :alt_sales_total,
      :alt_shipping_cost,
      :can_have_stackable,
      :contrib_pct,
      :created_date,
      :currency_name,
      :discount_rate,
      :discount_total,
      :due_date,
      :email,
      :end_date,
      :est_gross_profit,
      :est_gross_profit_percent,
      :exchange_rate,
      :expected_close_date,
      :fax,
      :fob,
      :handling_cost,
      :handling_tax1_rate,
      :handling_tax2_rate,
      :include_in_forecast,
      :is_taxable,
      :last_modified_date,
      :linked_tracking_numbers,
      :memo,
      :message,
      :one_time,
      :other_ref_num,
      :probability,
      :recur_annually,
      :recur_monthly,
      :recur_quarterly,
      :recur_weekly,
      :ship_date,
      :ship_is_residential,
      :shipping_cost,
      :shipping_tax1_rate,
      :shipping_tax2_rate,
      :source,
      :start_date,
      :status,
      :sub_total,
      :sync_partner_teams,
      :sync_sales_teams,
      :tax2_total,
      :tax_details_override,
      :tax_point_date,
      :tax_rate,
      :tax_reg_override,
      :tax_total,
      :title,
      :to_be_emailed,
      :to_be_faxed,
      :to_be_printed,
      :total,
      :total_cost_estimate,
      :tracking_numbers,
      :tran_date,
      :tran_id,
      :vat_reg_num,
      :visible_to_customer,
    ].each do |field|
      expect(estimate).to have_field(field)
    end
  end

  it 'has all the right fields with specific classes' do
    {
      billing_address: NetSuite::Records::Address,
      custom_field_list: NetSuite::Records::CustomFieldList,
      item_list: NetSuite::Records::EstimateItemList,
      promotions_list: NetSuite::Records::PromotionsList,
      shipping_address: NetSuite::Records::Address,
    }.each do |field, klass|
      expect(estimate).to have_field(field, klass)
    end
  end

  it 'has all the right record refs' do
    [
      :bill_address_list,
      :billing_schedule,
      :klass,
      :created_from,
      :currency,
      :custom_form,
      :department,
      :discount_item,
      :entity,
      :entity_status,
      :entity_tax_reg_num,
      :forecast_type,
      :handling_tax_code,
      :job,
      :lead_source,
      :location,
      :message_sel,
      :nexus,
      :opportunity,
      :partner,
      :promo_code,
      :sales_group,
      :sales_rep,
      :ship_address_list,
      :ship_method,
      :shipping_tax_code,
      :subsidiary,
      :subsidiary_tax_reg_num,
      :tax_item,
      :terms,
    ].each do |record_ref|
      expect(estimate).to have_record_ref(record_ref)
    end
  end

  describe '#order_status' do
    it 'can be set from attributes'
    it 'can be set from a EstimateStatus object'
  end

  describe '#item_list' do
    it 'can be set from attributes' do
      attributes = {
        :item => {
          :amount => 10
        }
      }
      estimate.item_list = attributes
      expect(estimate.item_list).to be_kind_of(NetSuite::Records::EstimateItemList)
      expect(estimate.item_list.items.length).to eql(1)
    end

    it 'can be set from a EstimateItemList object' do
      item_list = NetSuite::Records::EstimateItemList.new
      estimate.item_list = item_list
      expect(estimate.item_list).to eql(item_list)
    end
  end

  describe '#transaction_bill_address' do
    it 'can be set from attributes'
    it 'can be set from a BillAddress object'
  end

  describe '#transaction_ship_address' do
    it 'can be set from attributes'
    it 'can be set from a ShipAddress object'
  end

  describe '#revenue_status' do
    it 'can be set from attributes'
    it 'can be set from a RevenueStatus object'
  end

  describe '#sales_team_list' do
    it 'can be set from attributes'
    it 'can be set from a EstimateSalesTeamList object'
  end

  describe '#partners_list' do
    it 'can be set from attributes'
    it 'can be set from a EstimatePartnersList object'
  end

  describe '#custom_field_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomFieldList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :alt_shipping_cost => 100 }) }

      it 'returns a Estimate instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Estimate, :external_id => 1], {}).and_return(response)
        estimate = NetSuite::Records::Estimate.get(:external_id => 1)
        expect(estimate).to be_kind_of(NetSuite::Records::Estimate)
        expect(estimate.alt_shipping_cost).to eql(100)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Estimate, :external_id => 1], {}).and_return(response)
        expect {
          NetSuite::Records::Estimate.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Estimate with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '.initialize' do
    context 'when the request is successful' do
      it 'returns an initialized sales order from the customer entity' do
        expect(NetSuite::Actions::Initialize).to receive(:call).with([NetSuite::Records::Estimate, customer], {}).and_return(response)
        estimate = NetSuite::Records::Estimate.initialize(customer)
        expect(estimate).to be_kind_of(NetSuite::Records::Estimate)
      end
    end

    context 'when the response is unsuccessful' do
      skip
    end
  end

  describe '#add' do
    let(:test_data) { { :email => 'test@example.com', :fax => '1234567890' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        estimate = NetSuite::Records::Estimate.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([estimate], {}).
            and_return(response)
        expect(estimate.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        estimate = NetSuite::Records::Estimate.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([estimate], {}).
            and_return(response)
        expect(estimate.add).to be_falsey
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        estimate = NetSuite::Records::Estimate.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([estimate], {}).
            and_return(response)
        expect(estimate.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        estimate = NetSuite::Records::Estimate.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([estimate], {}).
            and_return(response)
        expect(estimate.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      estimate.email   = 'something@example.com'
      estimate.tran_id = '4'
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'tranSales:email'  => 'something@example.com',
        'tranSales:tranId' => '4'
      }
      expect(estimate.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(estimate.record_type).to eql('tranSales:Estimate')
    end
  end

  skip "closing a sales order" do
    it "closes each line to close the sales order" do
      attributes = sales_order.attributes
      attributes[:item_list].items.each do |item|
        item.is_closed = true
        item.attributes = item.attributes.slice(:line, :is_closed)
      end

      sales_order.update({ item_list: attributes[:item_list] })
    end
  end
end
