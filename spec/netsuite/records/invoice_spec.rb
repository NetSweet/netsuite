require 'spec_helper'

describe NetSuite::Records::Invoice do
  let(:invoice) { NetSuite::Records::Invoice.new }
  let(:customer) { NetSuite::Records::Customer.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

  it 'has all the right fields' do
    [
      :alt_handling_cost, :alt_shipping_cost, :amount_paid, :amount_remaining, :balance, :bill_address,
      :billing_schedule, :contrib_pct, :created_date, :created_from, :currency_name,
      :deferred_revenue, :department, :discount_amount, :discount_date, :discount_item, :discount_rate,
      :due_date, :email, :end_date, :est_gross_profit, :est_gross_profit_percent, :exchange_rate,
      :exclude_commission, :exp_cost_disc_amount, :exp_cost_disc_print, :exp_cost_disc_rate, :exp_cost_disc_tax_1_amt,
      :exp_cost_disc_taxable, :exp_cost_discount, :exp_cost_list, :exp_cost_tax_code, :exp_cost_tax_rate_1,
      :exp_cost_tax_rate_2, :fax, :fob, :gift_cert_applied, :gift_cert_redemption_list, :handling_cost, :handling_tax_1_rate,
      :handling_tax_2_rate, :handling_tax_code, :is_taxable, :item_cost_disc_amount, :item_cost_disc_print,
      :item_cost_disc_rate, :item_cost_disc_tax_1_amt, :item_cost_disc_taxable, :item_cost_discount, :item_cost_list,
      :item_cost_tax_code, :item_cost_tax_rate_1, :item_cost_tax_rate_2, :job, :last_modified_date,
      :lead_source, :linked_tracking_numbers, :location, :memo, :message, :message_sel, :on_credit_hold, :opportunity,
      :other_ref_name, :partner, :partners_list, :promo_code, :recognized_revenue, :rev_rec_end_date,
      :rev_rec_on_rev_commitment, :rev_rec_schedule, :rev_rec_start_date, :revenue_status, :sales_effective_date,
      :sales_group, :sales_rep, :sales_team_list, :ship_address, :ship_date, :ship_group_list,
      :ship_method, :shipping_cost, :shipping_tax_1_rate, :shipping_tax_2_rate, :shipping_tax_code, :source, :start_date,
      :status, :subsidiary, :sync_partner_teams, :sync_sales_teams, :tax_2_total, :tax_item, :tax_rate,
      :tax_total, :terms, :time_disc_amount, :time_disc_print, :time_disc_rate, :time_disc_tax_1_amt, :time_disc_taxable,
      :time_discount, :time_list, :time_tax_code, :time_tax_rate_1, :time_tax_rate_2, :to_be_emailed, :to_be_faxed,
      :to_be_printed, :total_cost_estimate, :tracking_numbers, :tran_date, :tran_id, :tran_is_vsoe_bundle,
      :vat_reg_num, :vsoe_auto_calc
    ].each do |field|
      invoice.should have_field(field)
    end
  end

  it 'has all the right read_only_fields' do
    [
      :sub_total, :discount_total, :total
    ].each do |field|
      NetSuite::Records::Invoice.should have_read_only_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :account, :bill_address_list, :custom_form, :entity, :klass, :posting_period, :ship_address_list
    ].each do |record_ref|
      invoice.should have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10
        }
      }
      invoice.custom_field_list = attributes
      invoice.custom_field_list.should be_kind_of(NetSuite::Records::CustomFieldList)
      invoice.custom_field_list.custom_fields.length.should eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      invoice.custom_field_list = custom_field_list
      invoice.custom_field_list.should eql(custom_field_list)
    end
  end

  describe '#item_list' do
    it 'can be set from attributes' do
      attributes = {
        :item => {
          :amount => 10
        }
      }
      invoice.item_list = attributes
      invoice.item_list.should be_kind_of(NetSuite::Records::InvoiceItemList)
      invoice.item_list.items.length.should eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      item_list = NetSuite::Records::InvoiceItemList.new
      invoice.item_list = item_list
      invoice.item_list.should eql(item_list)
    end
  end

  describe '#transaction_bill_address' do
    it 'has a transaction_bill_address field that builds a BillAddress object from attributes' do
      invoice.transaction_bill_address = {
        :"@xmlns:platform_common" => 'urn:common_2011_2.platform.webservices.netsuite.com',
        :bill_addr1               => '123 Happy Lane',
        :bill_city                => 'Los Angeles',
        :bill_country             => '_unitedStates',
        :bill_state               => 'CA',
        :bill_zip                 => '90007'
      }
      invoice.transaction_bill_address.should be_kind_of(NetSuite::Records::BillAddress)
      invoice.transaction_bill_address.bill_city.should eql('Los Angeles')
    end

    it 'can be set with a BillAddress object' do
      bill_address = NetSuite::Records::BillAddress.new
      invoice.transaction_bill_address = bill_address
      invoice.transaction_bill_address.should eql(bill_address)
    end
  end

  describe '#transaction_ship_address' do
    it 'has a transaction_ship_address field that builds a ShipAddress object from attributes' do
      invoice.transaction_ship_address = {
        :"@xmlns:platform_common" => 'urn:common_2011_2.platform.webservices.netsuite.com',
        :ship_addr1               => '123 Happy Lane',
        :ship_city                => 'Los Angeles',
        :ship_country             => '_unitedStates',
        :ship_is_residential      => false,
        :ship_state               => 'CA',
        :ship_zip                 => '90007'
      }
      invoice.transaction_ship_address.should be_kind_of(NetSuite::Records::ShipAddress)
      invoice.transaction_ship_address.ship_addr1.should eql('123 Happy Lane')
    end

    it 'can be set with a ShipAddress object' do
      ship_address = NetSuite::Records::ShipAddress.new
      invoice.transaction_ship_address = ship_address
      invoice.transaction_ship_address.should eql(ship_address)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_person => true }) }

      it 'returns an Invoice instance populated with the data from the response object' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::Invoice, :external_id => 10).and_return(response)
        invoice = NetSuite::Records::Invoice.get(:external_id => 10)
        invoice.should be_kind_of(NetSuite::Records::Invoice)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        NetSuite::Actions::Get.should_receive(:call).with(NetSuite::Records::Invoice, :external_id => 10).and_return(response)
        lambda {
          NetSuite::Records::Invoice.get(:external_id => 10)
        }.should raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Invoice with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '.initialize' do
    context 'when the request is successful' do
      it 'returns an initialized invoice from the customer entity' do
        NetSuite::Actions::Initialize.should_receive(:call).with(NetSuite::Records::Invoice, customer).and_return(response)
        invoice = NetSuite::Records::Invoice.initialize(customer)
        invoice.should be_kind_of(NetSuite::Records::Invoice)
      end
    end

    context 'when the response is unsuccessful' do
      pending
    end
  end

  describe '#add' do
    let(:test_data) { { :email => 'test@example.com', :fax => '1234567890' } }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        invoice = NetSuite::Records::Invoice.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with(invoice).
            and_return(response)
        invoice.add.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        invoice = NetSuite::Records::Invoice.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with(invoice).
            and_return(response)
        invoice.add.should be_false
      end
    end
  end

  describe '#to_record' do
    before do
      invoice.email   = 'something@example.com'
      invoice.tran_id = '4'
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'tranSales:email'  => 'something@example.com',
        'tranSales:tranId' => '4'
      }
      invoice.to_record.should eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      invoice.record_type.should eql('tranSales:Invoice')
    end
  end

end
