require 'spec_helper'

describe NetSuite::Records::SalesOrder do
  let(:salesorder) { NetSuite::Records::SalesOrder.new }
  let(:customer) { NetSuite::Records::Customer.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

  it 'has all the right fields' do
    [
      :alt_handling_cost, :alt_shipping_cost, :amount_paid, :amount_remaining, :applied, :auto_apply,
      :balance, :bill_address, :contrib_pct, :created_date, :currency_name, :deferred_revenue,
      :discount_rate, :discount_total, :email, :end_date, :est_gross_profit, :est_gross_profit_percent,
      :exchange_rate, :exclude_commission, :fax, :gift_cert_applied, :gift_cert_available,
      :gift_cert_total, :handling_cost, :handling_tax1_rate, :handling_tax2_rate, :is_taxable,
      :last_modified_date, :memo, :message, :on_credit_hold, :other_ref_num, :recognized_revenue,
      :rev_rec_on_rev_commitment, :sales_effective_date, :shipping_cost, :shipping_tax1_rate,
      :shipping_tax2_rate, :source, :start_date, :status, :sub_total, :sync_partner_teams,
      :sync_sales_teams, :tax2_total, :tax_rate, :tax_total, :to_be_emailed, :to_be_faxed, :to_be_printed,
      :total, :total_cost_estimate, :tran_date, :tran_id, :tran_is_vsoe_bundle, :unapplied, :vat_reg_num,
      :vsoe_auto_calc, :cc_approved
    ].each do |field|
      expect(salesorder).to have_field(field)
    end
  end

  it 'has all the right fields with specific classes' do
    {
      billing_address: NetSuite::Records::Address,
      custom_field_list: NetSuite::Records::CustomFieldList,
      gift_cert_redemption_list: NetSuite::Records::GiftCertRedemptionList,
      item_list: NetSuite::Records::SalesOrderItemList,
      null_field_list: NetSuite::Records::NullFieldList,
      promotions_list: NetSuite::Records::PromotionsList,
      ship_group_list: NetSuite::Records::SalesOrderShipGroupList,
      shipping_address: NetSuite::Records::Address,
      transaction_bill_address: NetSuite::Records::BillAddress,
      transaction_ship_address: NetSuite::Records::ShipAddress,
    }.each do |field, klass|
      expect(salesorder).to have_field(field, klass)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :bill_address_list, :created_from, :currency, :custom_form, :department, :discount_item,
      :entity, :gift_cert, :handling_tax_code, :job, :klass, :lead_source, :location, :message_sel,
      :opportunity, :partner, :posting_period, :promo_code, :sales_group, :sales_rep,
      :ship_method, :shipping_tax_code, :subsidiary, :tax_item
    ].each do |record_ref|
      expect(salesorder).to have_record_ref(record_ref)
    end
  end

  describe '#order_status' do
    it 'can be set from attributes'
    it 'can be set from a SalesOrderOrderStatus object'
  end

  describe '#item_list' do
    it 'can be set from attributes' do
      attributes = {
        :item => {
          :amount => 10
        }
      }
      salesorder.item_list = attributes
      expect(salesorder.item_list).to be_kind_of(NetSuite::Records::SalesOrderItemList)
      expect(salesorder.item_list.items.length).to eql(1)
    end

    it 'can be set from a SalesOrderItemList object' do
      item_list = NetSuite::Records::SalesOrderItemList.new
      salesorder.item_list = item_list
      expect(salesorder.item_list).to eql(item_list)
    end
  end

  describe '#gift_cert_redemption_list' do
    it 'can be set from attributes' do
      attributes = {
        :gift_cert_redemption => {
          :auth_code_amt_remaining => 20
        }
      }
      salesorder.gift_cert_redemption_list = attributes
      expect(salesorder.gift_cert_redemption_list).to be_kind_of(NetSuite::Records::GiftCertRedemptionList)
      expect(salesorder.gift_cert_redemption_list.gift_cert_redemptions.length).to eql(1)
    end

    it 'can be set from a GiftCertRedemptionList object' do
      gift_cert_redemption_list = NetSuite::Records::GiftCertRedemptionList.new
      salesorder.gift_cert_redemption_list = gift_cert_redemption_list
      expect(salesorder.gift_cert_redemption_list).to eql(gift_cert_redemption_list)
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
    it 'can be set from a SalesOrderSalesTeamList object'
  end

  describe '#partners_list' do
    it 'can be set from attributes'
    it 'can be set from a SalesOrderPartnersList object'
  end

  describe '#custom_field_list' do
    it 'can be set from attributes'
    it 'can be set from a CustomFieldList object'
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :alt_shipping_cost => 100 }) }

      it 'returns a SalesOrder instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::SalesOrder, :external_id => 1], {}).and_return(response)
        salesorder = NetSuite::Records::SalesOrder.get(:external_id => 1)
        expect(salesorder).to be_kind_of(NetSuite::Records::SalesOrder)
        expect(salesorder.alt_shipping_cost).to eql(100)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::SalesOrder, :external_id => 1], {}).and_return(response)
        expect {
          NetSuite::Records::SalesOrder.get(:external_id => 1)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::SalesOrder with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '.initialize' do
    context 'when the request is successful' do
      it 'returns an initialized sales order from the customer entity' do
        expect(NetSuite::Actions::Initialize).to receive(:call).with([NetSuite::Records::SalesOrder, customer], {}).and_return(response)
        salesorder = NetSuite::Records::SalesOrder.initialize(customer)
        expect(salesorder).to be_kind_of(NetSuite::Records::SalesOrder)
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
        salesorder = NetSuite::Records::SalesOrder.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([salesorder], {}).
            and_return(response)
        expect(salesorder.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        salesorder = NetSuite::Records::SalesOrder.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([salesorder], {}).
            and_return(response)
        expect(salesorder.add).to be_falsey
      end
    end
  end

  describe '#attach_file' do
    let(:test_data) { { :email => 'test@example.com', :fax => '1234567890' } }
    let(:file) { double('file') }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        sales_order = NetSuite::Records::SalesOrder.new(test_data)
        expect(NetSuite::Actions::AttachFile).to receive(:call).
          with([sales_order, file], {}).
          and_return(response)
        expect(sales_order.attach_file(file)).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        sales_order = NetSuite::Records::SalesOrder.new(test_data)
        expect(NetSuite::Actions::AttachFile).to receive(:call).
          with([sales_order, file], {}).
          and_return(response)
        expect(sales_order.attach_file(file)).to be_falsey
      end
    end
  end

  describe '#delete' do
    let(:test_data) { { :internal_id => '1' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        salesorder = NetSuite::Records::SalesOrder.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([salesorder], {}).
            and_return(response)
        expect(salesorder.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        salesorder = NetSuite::Records::SalesOrder.new(test_data)
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([salesorder], {}).
            and_return(response)
        expect(salesorder.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      salesorder.email   = 'something@example.com'
      salesorder.tran_id = '4'
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'tranSales:email'  => 'something@example.com',
        'tranSales:tranId' => '4'
      }
      expect(salesorder.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(salesorder.record_type).to eql('tranSales:SalesOrder')
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
