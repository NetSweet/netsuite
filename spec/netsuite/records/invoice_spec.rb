require 'spec_helper'

describe NetSuite::Records::Invoice do
  let(:invoice) { NetSuite::Records::Invoice.new }
  let(:customer) { NetSuite::Records::Customer.new }
  let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

  it 'has all the right fields' do
    [
      :balance, :bill_address,
      :billing_schedule, :contrib_pct, :created_date, :currency_name,
      :deferred_revenue, :discount_amount, :discount_date, :discount_rate,
      :due_date, :email, :end_date, :est_gross_profit, :est_gross_profit_percent, :exchange_rate,
      :exclude_commission, :exp_cost_disc_amount, :exp_cost_disc_print, :exp_cost_disc_rate, :exp_cost_disc_tax_1_amt,
      :exp_cost_disc_taxable, :exp_cost_discount, :exp_cost_list, :exp_cost_tax_code, :exp_cost_tax_rate_1,
      :exp_cost_tax_rate_2, :fax, :fob, :gift_cert_redemption_list, :handling_tax_1_rate,
      :handling_tax_2_rate, :handling_tax_code, :is_taxable, :item_cost_disc_amount, :item_cost_disc_print,
      :item_cost_disc_rate, :item_cost_disc_tax_1_amt, :item_cost_disc_taxable, :item_cost_discount, :item_cost_list,
      :item_cost_tax_code, :item_cost_tax_rate_1, :item_cost_tax_rate_2, :last_modified_date,
      :linked_tracking_numbers, :memo, :message, :message_sel, :on_credit_hold, :opportunity,
      :other_ref_num, :partners_list, :rev_rec_end_date,
      :rev_rec_on_rev_commitment, :rev_rec_schedule, :rev_rec_start_date, :revenue_status, :sales_effective_date,
      :sales_group, :sales_team_list, :ship_address, :ship_date, :ship_group_list,
      :shipping_cost, :shipping_tax_1_rate, :shipping_tax_2_rate, :shipping_tax_code, :source, :start_date,
      :status, :sync_partner_teams, :sync_sales_teams, :tax_2_total,
      :tax_total, :time_disc_amount, :time_disc_print, :time_disc_rate, :time_disc_tax_1_amt, :time_disc_taxable,
      :time_discount, :time_list, :time_tax_code, :time_tax_rate_1, :time_tax_rate_2, :to_be_emailed, :to_be_faxed,
      :to_be_printed, :total_cost_estimate, :tracking_numbers, :tran_date, :tran_id, :tran_is_vsoe_bundle,
      :vat_reg_num, :vsoe_auto_calc, :tax_rate
    ].each do |field|
      expect(invoice).to have_field(field)
    end
  end

  it 'has all the right fields with specific classes' do
    {
      transaction_bill_address: NetSuite::Records::BillAddress,
      transaction_ship_address: NetSuite::Records::ShipAddress,
      item_list: NetSuite::Records::InvoiceItemList,
      custom_field_list: NetSuite::Records::CustomFieldList,
      shipping_address: NetSuite::Records::Address,
      billing_address: NetSuite::Records::Address,
      null_field_list: NetSuite::Records::NullFieldList,
    }.each do |field, klass|
      expect(invoice).to have_field(field, klass)
    end
  end

  it 'has all the right read_only_fields' do
    [
      :sub_total, :discount_total, :total, :alt_handling_cost, :alt_shipping_cost, :gift_cert_applied,
      :handling_cost, :recognized_revenue, :amount_remaining, :amount_paid
    ].each do |field|
      expect(NetSuite::Records::Invoice).to have_read_only_field(field)
    end
  end

  it 'has all the right search_only_fields' do
    [
      :abbrev, :account_type, :acct_corp_card_exp, :actual_production_end_date,
      :actual_production_start_date, :actual_ship_date, :alt_sales_amount,
      :alt_sales_net_amount, :amount, :amount_unbilled,
      :applied_to_foreign_amount, :applied_to_is_fx_variance,
      :applied_to_link_amount, :applied_to_link_type, :applied_to_transaction,
      :applying_foreign_amount, :applying_is_fx_variance, :applying_link_amount,
      :applying_link_type, :applying_transaction, :auth_code,
      :auto_calculate_lag, :avs_street_match, :avs_zip_match, :billable,
      :bill_address, :bill_address1, :bill_address2, :bill_address3,
      :bill_addressee, :bill_attention, :bill_city, :bill_country,
      :bill_country_code, :billed_date, :billing_amount, :billing_transaction,
      :bill_phone, :bill_state, :bill_variance_status, :bill_zip, :bin_number,
      :bin_number_quantity, :bom_quantity, :build_entire_assembly,
      :build_variance, :built, :can_have_stackable_promotions, :catch_up_period,
      :cc_customer_code, :cc_exp_date, :cc_holder_name, :cc_number, :cc_street,
      :cc_zip_code, :cleared, :closed, :close_date, :cogs_amount,
      :commission_effective_date, :commit, :component_yield,
      :confirmation_number, :contribution, :contribution_primary,
      :cost_component_amount, :cost_component_category, :cost_component_item,
      :cost_component_quantity, :cost_component_standard_cost, :cost_estimate,
      :cost_estimate_rate, :cost_estimate_type, :created_by, :credit_amount,
      :csc_match, :custom_gl, :cust_type, :date_created, :days_open,
      :days_overdue, :debit_amount, :defer_rev_rec, :deposit_date,
      :deposit_transaction, :doc_unit, :dr_account, :effective_rate,
      :entity_status, :est_gross_profit_pct, :exclude_from_rate_request,
      :expected_close_date, :expected_receipt_date, :expense_category,
      :expense_date, :firmed, :forecast_type, :fulfilling_transaction,
      :fx_account, :fx_amount, :fx_cost_estimate, :fx_cost_estimate_rate,
      :fx_est_gross_profit, :fx_tran_cost_estimate, :fx_vsoe_allocation,
      :fx_vsoe_amount, :fx_vsoe_price, :gco_availabel_to_charge,
      :gco_available_to_refund, :gco_avs_street_match, :gco_avs_zip_match,
      :gco_buyer_account_age, :gco_buyer_ip, :gco_charge_amount,
      :gco_chargeback_amount, :gco_confirmed_charged_total,
      :gco_confirmed_refunded_total, :gco_creditcard_number, :gco_csc_match,
      :gco_financial_state, :gco_fulfillment_state, :gco_order_id,
      :gco_order_total, :gco_promotion_amount, :gco_promotion_name,
      :gco_refund_amount, :gco_shipping_total, :gco_state_changed_detail,
      :gift_cert, :gross_amount, :include_in_forecast, :incoterm,
      :interco_status, :interco_transaction, :inventory_location,
      :inventory_subsidiary, :in_vsoe_bundle, :is_allocation, :is_backflush,
      :is_gco_chargeback, :is_gco_charge_confirmed, :is_gco_payment_guaranteed,
      :is_gco_refund_confirmed, :is_inside_delivery, :is_inside_pickup,
      :is_intercompany_adjustment, :is_in_transit_payment, :is_multi_ship_to,
      :is_reversal, :is_rev_rec_transaction, :is_scrap, :is_ship_address,
      :is_transfer_price_costing, :is_wip, :item, :item_fulfillment_choice,
      :item_revision, :landed_cost_per_line, :line, :line_sequence_number,
      :line_unique_key, :location_auto_assigned, :main_line, :main_name,
      :manufacturing_routing, :match_bill_to_receipt, :memo_main, :memorized,
      :merchant_account, :multi_subsidiary, :net_amount, :net_amount_no_tax,
      :next_bill_date, :no_auto_assign_location, :non_reimbursable,
      :one_time_total, :options, :order_allocation_strategy, :order_priority,
      :originator, :overhead_parent_item,
      :override_installments, :package_count, :paid_amount, :paid_transaction,
      :partner_contribution, :partner_role, :partner_team_member,
      :paying_amount, :paying_transaction, :payment_approved,
      :payment_event_date, :payment_event_hold_reason,
      :payment_event_purchase_card_used, :payment_event_purchase_data_sent,
      :payment_event_result, :payment_event_type, :payment_hold,
      :payment_method, :payment_option, :pay_pal_pending, :pay_pal_status,
      :pay_pal_tran_id, :payroll_batch, :pn_ref_num, :po_rate, :posting,
      :price_level, :print, :probability, :projected_amount, :project_task,
      :purchase_order, :quantity, :quantity_billed, :quantity_committed,
      :quantity_packed, :quantity_picked, :quantity_rev_committed,
      :quantity_ship_recv, :quantity_uom, :rate,
      :realized_gain_posting_transaction, :recur_annually_total,
      :recur_monthly_total, :recur_quarterly_total, :recur_weekly_total,
      :ref_number, :requested_date, :rev_commit_status,
      :rev_committing_transaction, :reversal_date, :reversal_number,
      :rg_account, :rg_amount, :sales_order, :sales_team_member,
      :sales_team_role, :scheduling_method, :serial_number, :serial_number_cost,
      :serial_number_cost_adjustment, :serial_number_quantity, :serial_numbers,
      :ship_address, :ship_address1, :ship_address2, :ship_address3,
      :ship_addressee, :ship_attention, :ship_carrier, :ship_city,
      :ship_complete, :ship_country, :ship_country_code, :ship_group,
      :ship_phone, :shipping_amount, :ship_recv_status_line, :ship_state,
      :ship_to, :ship_zip, :signed_amount, :subscription, :subscription_line,
      :tax_amount, :tax_code, :tax_line, :tax_period, :term_in_months,
      :terms_of_sale, :title, :to_subsidiary, :tran_est_gross_profit,
      :tran_fx_est_gross_profit, :transaction_discount, :transaction_line_type,
      :transaction_number, :transfer_location, :transfer_order_item_line,
      :transfer_order_quantity_committed, :transfer_order_quantity_packed,
      :transfer_order_quantity_picked, :transfer_order_quantity_received,
      :transfer_order_quantity_shipped, :type, :unit, :unit_cost_override,
      :vend_type, :visible_to_customer, :vsoe_allocation, :vsoe_amount,
      :vsoe_deferral, :vsoe_delivered, :vsoe_permit_discount, :vsoe_price,
      :web_site,
    ].each do |field|
      expect(NetSuite::Records::Invoice).to have_search_only_field(field)
    end
  end

  it 'has the right record_refs' do
    [
      :account, :bill_address_list, :job, :custom_form, :department, :entity, :klass, :posting_period, :ship_address_list, :terms,
      :created_from, :location, :sales_rep, :ship_method, :tax_item, :partner, :lead_source, :promo_code, :subsidiary, :discount_item
    ].each do |record_ref|
      expect(invoice).to have_record_ref(record_ref)
    end
  end

  describe '#custom_field_list' do
    it 'can be set from attributes' do
      attributes = {
        :custom_field => {
          :amount => 10,
          :internal_id => 'custfield_amount'
        }
      }
      invoice.custom_field_list = attributes
      expect(invoice.custom_field_list).to be_kind_of(NetSuite::Records::CustomFieldList)
      expect(invoice.custom_field_list.custom_fields.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      custom_field_list = NetSuite::Records::CustomFieldList.new
      invoice.custom_field_list = custom_field_list
      expect(invoice.custom_field_list).to eql(custom_field_list)
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
      expect(invoice.item_list).to be_kind_of(NetSuite::Records::InvoiceItemList)
      expect(invoice.item_list.items.length).to eql(1)
    end

    it 'can be set from a CustomFieldList object' do
      item_list = NetSuite::Records::InvoiceItemList.new
      invoice.item_list = item_list
      expect(invoice.item_list).to eql(item_list)
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
      expect(invoice.transaction_bill_address).to be_kind_of(NetSuite::Records::BillAddress)
      expect(invoice.transaction_bill_address.bill_city).to eql('Los Angeles')
    end

    it 'can be set with a BillAddress object' do
      bill_address = NetSuite::Records::BillAddress.new
      invoice.transaction_bill_address = bill_address
      expect(invoice.transaction_bill_address).to eql(bill_address)
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
      expect(invoice.transaction_ship_address).to be_kind_of(NetSuite::Records::ShipAddress)
      expect(invoice.transaction_ship_address.ship_addr1).to eql('123 Happy Lane')
    end

    it 'can be set with a ShipAddress object' do
      ship_address = NetSuite::Records::ShipAddress.new
      invoice.transaction_ship_address = ship_address
      expect(invoice.transaction_ship_address).to eql(ship_address)
    end
  end

  describe '#shipping_address' do
    it 'can be set from attributes' do
      attributes = {
        :country => "_unitedStates",
        :attention => "William Sanders",
        :addressee => "William Sanders",
        :addr1 => "test1",
        :addr2 => "test2",
        :city => "San Francisco",
        :state => "CA",
        :zip => "94131",
        :addr_text => "William Sanders<br>William Sanders<br>test1<br>test2<br>San Francisco CA 94131",
        :override => false,
        :"@xmlns:platform_common" => "urn:common_2016_1.platform.webservices.netsuite.com"
      }

      invoice.shipping_address = attributes
      expect(invoice.shipping_address).to be_kind_of(NetSuite::Records::Address)
      expect(invoice.shipping_address.addressee).to eql("William Sanders")
    end

    it 'can be set from a ItemVendorList object' do
      shipping_address = NetSuite::Records::Address.new
      invoice.shipping_address = shipping_address
      expect(invoice.shipping_address).to eql(shipping_address)
    end
  end

  describe '#billing_address' do
    it 'can be set from attributes' do
      attributes = {
        :country => "_unitedStates",
        :attention => "William Sanders",
        :addressee => "William Sanders",
        :addr1 => "test1",
        :addr2 => "test2",
        :city => "San Francisco",
        :state => "CA",
        :zip => "94131",
        :addr_text => "William Sanders<br>William Sanders<br>test1<br>test2<br>San Francisco CA 94131",
        :override => false,
        :"@xmlns:platform_common" => "urn:common_2016_1.platform.webservices.netsuite.com"
      }

      invoice.billing_address = attributes
      expect(invoice.billing_address).to be_kind_of(NetSuite::Records::Address)
      expect(invoice.billing_address.addressee).to eql("William Sanders")
    end

    it 'can be set from a ItemVendorList object' do
      billing_address = NetSuite::Records::Address.new
      invoice.billing_address = billing_address
      expect(invoice.billing_address).to eql(billing_address)
    end
  end

  describe '.get' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :is_person => true }) }

      it 'returns an Invoice instance populated with the data from the response object' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Invoice, {:external_id => 10}], {}).and_return(response)
        invoice = NetSuite::Records::Invoice.get(:external_id => 10)
        expect(invoice).to be_kind_of(NetSuite::Records::Invoice)
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'raises a RecordNotFound exception' do
        expect(NetSuite::Actions::Get).to receive(:call).with([NetSuite::Records::Invoice, {:external_id => 10}], {}).and_return(response)
        expect {
          NetSuite::Records::Invoice.get(:external_id => 10)
        }.to raise_error(NetSuite::RecordNotFound,
          /NetSuite::Records::Invoice with OPTIONS=(.*) could not be found/)
      end
    end
  end

  describe '.search' do
    context 'when the response is successful' do
      let(:response) do
        NetSuite::Response.new(
          :success => true,
          :body => {
            :status => { :@is_success => 'true' },
            :total_records => '1',
            :search_row_list => {
              :search_row => {
                :basic => {
                  :alt_name => {:search_value=>'A Awesome Name'},
                  :"@xmlns:platform_common"=>'urn:common_2012_1.platform.webservices.netsuite.com'},
                  :"@xsi:type" => 'listRel:ItemSearchRow'
                }
              }
            }
          )
      end

      it 'returns an Invoice instance populated with the data from the response object' do
        allow(NetSuite::Actions::Search).to receive(:call).and_return(response)

        invoice = NetSuite::Records::Invoice.search(
          criteria: {
            basic: [
              {
                field: 'type',
                operator: 'anyOf',
                type: 'SearchEnumMultiSelectField',
                value: ['_invoice']
              }
            ]
          },
          columns: {
            'tranSales:basic' => [
              'platformCommon:internalId/' => {}
            ]
          }
        ).results[0]
        expect(invoice).to be_kind_of(NetSuite::Records::Invoice)
      end
    end
  end

  describe '.initialize' do
    context 'when the request is successful' do
      it 'returns an initialized invoice from the customer entity' do
        expect(NetSuite::Actions::Initialize).to receive(:call).with([NetSuite::Records::Invoice, customer], {}).and_return(response)
        invoice = NetSuite::Records::Invoice.initialize(customer)
        expect(invoice).to be_kind_of(NetSuite::Records::Invoice)
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
        invoice = NetSuite::Records::Invoice.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([invoice], {}).
            and_return(response)
        expect(invoice.add).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        invoice = NetSuite::Records::Invoice.new(test_data)
        expect(NetSuite::Actions::Add).to receive(:call).
            with([invoice], {}).
            and_return(response)
        expect(invoice.add).to be_falsey
      end
    end
  end

  describe '#attach_file' do
    let(:test_data) { { :email => 'test@example.com', :fax => '1234567890' } }
    let(:file) { double('file') }

    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        invoice = NetSuite::Records::Invoice.new(test_data)
        expect(NetSuite::Actions::AttachFile).to receive(:call).
          with([invoice, file], {}).
          and_return(response)
        expect(invoice.attach_file(file)).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        invoice = NetSuite::Records::Invoice.new(test_data)
        expect(NetSuite::Actions::AttachFile).to receive(:call).
          with([invoice, file], {}).
          and_return(response)
        expect(invoice.attach_file(file)).to be_falsey
      end
    end
  end

  describe '#delete' do
    context 'when the response is successful' do
      let(:response) { NetSuite::Response.new(:success => true, :body => { :internal_id => '1' }) }

      it 'returns true' do
        invoice = NetSuite::Records::Invoice.new
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([invoice], {}).
            and_return(response)
        expect(invoice.delete).to be_truthy
      end
    end

    context 'when the response is unsuccessful' do
      let(:response) { NetSuite::Response.new(:success => false, :body => {}) }

      it 'returns false' do
        invoice = NetSuite::Records::Invoice.new
        expect(NetSuite::Actions::Delete).to receive(:call).
            with([invoice], {}).
            and_return(response)
        expect(invoice.delete).to be_falsey
      end
    end
  end

  describe '#to_record' do
    before do
      invoice.email   = 'something@example.com'
      invoice.tran_id = '4'
      invoice.close_date = '2021-08-04' # Search only, excluded
    end
    it 'can represent itself as a SOAP record' do
      record = {
        'tranSales:email'  => 'something@example.com',
        'tranSales:tranId' => '4'
      }
      expect(invoice.to_record).to eql(record)
    end
  end

  describe '#record_type' do
    it 'returns a string representation of the SOAP type' do
      expect(invoice.record_type).to eql('tranSales:Invoice')
    end
  end

end
