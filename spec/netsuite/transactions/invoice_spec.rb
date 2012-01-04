require 'spec_helper'

describe NetSuite::Transactions::Invoice do
  let(:invoice) { NetSuite::Transactions::Invoice.new }
  let(:customer) { NetSuite::Records::Customer.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

  it 'has all the right fields' do
    [
      :created_date, :last_modified_date, :custom_form, :entity, :tran_date, :tran_id, :source, :created_from, :posting_period,
      :opportunity, :department, :klass, :terms, :location, :subsidiary, :due_date, :discount_date, :discount_amount, :sales_rep,
      :contrib_pct, :partner, :lead_source, :start_date, :end_date, :other_ref_name, :memo, :sales_effective_date,
      :exclude_commission, :total_cost_estimate, :est_gross_profit, :est_gross_profit_percent, :rev_rec_schedule,
      :rev_rec_start_date, :rev_rec_end_date, :amount_paid, :amount_remaining, :balance, :account, :on_credit_hold,
      :exchange_rate, :currency_name, :promo_code, :discount_item, :discount_rate, :is_taxable, :tax_item, :tax_rate,
      :to_be_printed, :to_be_emailed, :to_be_faxed, :fax, :message_sel, :message, :transaction_bill_address, :bill_address_list,
      :bill_address, :transaction_ship_address, :ship_address_list, :ship_address, :fob, :ship_date, :ship_method, :shipping_cost,
      :shipping_tax_1_rate, :shipping_tax_2_rate, :shipping_tax_code, :handling_tax_code, :handling_tax_1_rate, :handling_cost,
      :handling_tax_2_rate, :tracking_numbers, :linked_tracking_numbers, :sales_group, :sub_total, :revenue_status,
      :recognized_revenue, :deferred_revenue, :rev_rec_on_rev_commitment, :sync_sales_teams, :discount_total, :tax_total,
      :alt_shipping_cost, :alt_handling_cost, :total, :status, :job, :billing_schedule, :email, :tax_2_total, :vat_reg_num,
      :exp_cost_discount, :item_cost_discount, :time_discount, :exp_cost_disc_rate, :item_cost_disc_rate, :time_disc_rate,
      :exp_cost_disc_amount, :exp_cost_tax_rate_1, :exp_cost_tax_rate_2, :item_cost_disc_amount, :exp_cost_tax_code,
      :exp_cost_disc_tax_1_amt, :item_cost_tax_rate_1, :time_disc_amount, :item_cost_tax_code, :exp_cost_disc_taxable,
      :item_cost_disc_taxable, :item_cost_tax_rate_2, :item_cost_disc_tax_1_amt, :item_cost_disc_print, :time_disc_taxable,
      :time_tax_rate_1, :exp_cost_disc_print, :time_tax_code, :time_disc_print, :gift_cert_applied, :time_disc_tax_1_amt,
      :tran_is_vsoe_bundle, :time_tax_rate_2, :vsoe_auto_calc, :sync_partner_teams, :sales_team_list, :partners_list, :item_list,
      :item_cost_list, :gift_cert_redemption_list, :exp_cost_list, :time_list, :ship_group_list, :custom_field_list
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
        invoice = NetSuite::Transactions::Invoice.initialize(customer)
        invoice.should be_kind_of(NetSuite::Transactions::Invoice)
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
        invoice = NetSuite::Transactions::Invoice.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with(invoice).
            and_return(response)
        invoice.add.should be_true
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        invoice = NetSuite::Transactions::Invoice.new(test_data)
        NetSuite::Actions::Add.should_receive(:call).
            with(invoice).
            and_return(response)
        invoice.add.should be_false
      end
    end
  end

end
