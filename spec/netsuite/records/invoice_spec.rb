require 'spec_helper'

describe NetSuite::Records::Invoice do
  let(:invoice) { NetSuite::Records::Invoice.new }
  let(:customer) { NetSuite::Records::Customer.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

  it 'has all the right fields' do
    [
      :alt_handling_cost, :alt_shipping_cost, :amount_paid, :amount_remaining, :balance, :bill_address,
      :billing_schedule, :contrib_pct, :created_date, :created_from, :currency_name, :custom_field_list,
      :deferred_revenue, :department, :discount_amount, :discount_date, :discount_item, :discount_rate,
      :discount_total, :due_date, :email, :end_date, :est_gross_profit, :est_gross_profit_percent, :exchange_rate,
      :exclude_commission, :exp_cost_disc_amount, :exp_cost_disc_print, :exp_cost_disc_rate, :exp_cost_disc_tax_1_amt,
      :exp_cost_disc_taxable, :exp_cost_discount, :exp_cost_list, :exp_cost_tax_code, :exp_cost_tax_rate_1,
      :exp_cost_tax_rate_2, :fax, :fob, :gift_cert_applied, :gift_cert_redemption_list, :handling_cost, :handling_tax_1_rate,
      :handling_tax_2_rate, :handling_tax_code, :is_taxable, :item_cost_disc_amount, :item_cost_disc_print,
      :item_cost_disc_rate, :item_cost_disc_tax_1_amt, :item_cost_disc_taxable, :item_cost_discount, :item_cost_list,
      :item_cost_tax_code, :item_cost_tax_rate_1, :item_cost_tax_rate_2, :item_list, :job, :klass, :last_modified_date,
      :lead_source, :linked_tracking_numbers, :location, :memo, :message, :message_sel, :on_credit_hold, :opportunity,
      :other_ref_name, :partner, :partners_list, :promo_code, :recognized_revenue, :rev_rec_end_date,
      :rev_rec_on_rev_commitment, :rev_rec_schedule, :rev_rec_start_date, :revenue_status, :sales_effective_date,
      :sales_group, :sales_rep, :sales_team_list, :ship_address, :ship_date, :ship_group_list,
      :ship_method, :shipping_cost, :shipping_tax_1_rate, :shipping_tax_2_rate, :shipping_tax_code, :source, :start_date,
      :status, :sub_total, :subsidiary, :sync_partner_teams, :sync_sales_teams, :tax_2_total, :tax_item, :tax_rate,
      :tax_total, :terms, :time_disc_amount, :time_disc_print, :time_disc_rate, :time_disc_tax_1_amt, :time_disc_taxable,
      :time_discount, :time_list, :time_tax_code, :time_tax_rate_1, :time_tax_rate_2, :to_be_emailed, :to_be_faxed,
      :to_be_printed, :total, :total_cost_estimate, :tracking_numbers, :tran_date, :tran_id, :tran_is_vsoe_bundle,
      :vat_reg_num, :vsoe_auto_calc
    ].each do |field|
      invoice.should have_field(field)
    end
  end

  it 'handles the "klass" field correctly'
  # This field maps to 'class' but cannot be set as such in Ruby as it will cause runtime errors.

  describe '.initialize' do
    context 'when the request is successful' do
      it 'returns an initialized invoice from the customer entity' do
        NetSuite::Actions::Initialize.should_receive(:call).with(customer).and_return(response)
        invoice = NetSuite::Records::Invoice.initialize(customer)
        invoice.should be_kind_of(NetSuite::Records::Invoice)
      end
    end

    context 'when the response is unsuccessful' do
      pending
    end
  end

  describe 'RecordRefs' do
    describe 'account' do
      it 'creates a RecordRef for this attribute' do
        invoice.account = {
          :@internal_id           => '123',
          :"@xmlns:platform_core" => 'urn:core_2011_2.platform.webservices.netsuite.com',
          :name                   => '1100 Accounts Receivable'
        }
        invoice.account.should be_kind_of(NetSuite::Records::RecordRef)
      end
    end

    describe 'bill_address_list' do
      it 'creates a RecordRef for this attribute' do
        invoice.bill_address_list = {
          :@internal_id           => '567',
          :"@xmlns:platform_core" => 'urn:core_2011_2.platform.webservices.netsuite.com',
          :name                   => '123 Happy Lane'
        }
        invoice.bill_address_list.should be_kind_of(NetSuite::Records::RecordRef)
      end
    end

    describe 'custom_form' do
      it 'creates a RecordRef for this attribute' do
        invoice.custom_form = {
          :@internal_id           => '101',
          :"@xmlns:platform_core" => 'urn:core_2011_2.platform.webservices.netsuite.com',
          :name                   => 'RP Test Product Invoice'
        }
        invoice.custom_form.should be_kind_of(NetSuite::Records::RecordRef)
      end
    end

    describe 'entity' do
      it 'creates a RecordRef for this attribute' do
        invoice.entity = {
          :@internal_id           => '988',
          :"@xmlns:platform_core" => 'urn:core_2011_2.platform.webservices.netsuite.com',
          :name                   => '100157 Shutter Fly'
        }
        invoice.entity.should be_kind_of(NetSuite::Records::RecordRef)
      end
    end

    describe 'posting_period' do
      it 'creates a RecordRef for this attribute' do
        invoice.posting_period = {
          :@internal_id           => '20',
          :"@xmlns:platform_core" => 'urn:core_2011_2.platform.webservices.netsuite.com',
          :name                   => 'Jan 2012'
        }
        invoice.posting_period.should be_kind_of(NetSuite::Records::RecordRef)
      end
    end

    describe 'ship_address_list' do
      it 'creates a RecordRef for this attribute' do
        invoice.ship_address_list = {
          :@internal_id           => '567',
          :"@xmlns:platform_core" => 'urn:core_2011_2.platform.webservices.netsuite.com',
          :name                   => '123 Happy Lane'
        }
        invoice.ship_address_list.should be_kind_of(NetSuite::Records::RecordRef)
      end
    end
  end

  it 'has a transaction_bill_address field that builds a BillAddress object' do
    invoice.transaction_bill_address = {
      :"@xmlns:platform_common" => 'urn:common_2011_2.platform.webservices.netsuite.com',
      :bill_addr1               => '123 Happy Lane',
      :bill_city                => 'Los Angeles',
      :bill_country             => '_unitedStates',
      :bill_state               => 'CA',
      :bill_zip                 => '90007'
    }
    invoice.transaction_bill_address.should be_kind_of(NetSuite::Records::BillAddress)
  end

  it 'has a transaction_ship_address field that builds a ShipAddress object' do
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

end
