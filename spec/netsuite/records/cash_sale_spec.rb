require 'spec_helper'

describe NetSuite::Records::CashSale do
  it 'has all the right fields' do
    [
      :alt_handling_cost, :alt_shipping_cost, :auth_code, :bill_address, :cc_approved, :cc_expire_date, :cc_is_purchase_card_bin,
      :cc_name, :cc_number, :cc_process_as_purchas_card, :cc_security_code, :cc_street, :cc_zip_code, :charge_it, :contrib_pct, :created_date,
      :currency_name, :debit_card_issue_no, :deferred_revenue, :discount_rate, :discount_total, :email, :end_date, :est_gross_profit,
      :est_gross_profit_percent, :exchange_rate, :exclude_commission, :exp_cost_disc_amount, :exp_cost_discprint,
      :exp_cost_disc_rate, :exp_cost_disc_tax1_amt, :exp_cost_disc_taxable, :exp_cost_tax_rate1, :exp_cost_tax_rate2, :fax, :fob,
      :gift_cert_applied, :handling_cost, :handling_tax1_rate, :handling_tax2_rate, :ignore_avs, :is_recurring_payment, :is_taxable,
      :item_cost_disc_amount, :item_cost_disc_print, :item_cost_disc_rate, :item_cost_disc_tax1_amt, :item_cost_disc_taxable, :item_cost_tax_rate1,
      :item_cost_tax_rate2, :last_modified_date, :linked_tracking_numbers, :memo, :message, :other_ref_num, :paypal_auth_id, :paypal_process,
      :pay_pal_status, :pay_pay_tran_id, :pn_ref_num, :recognized_revenue, :rev_rec_end_date, :rev_rec_on_rev_commitment, :rev_rec_state_date,
      :sales_effective_date, :ship_address, :ship_date, :shipping_cost, :shipping_tax1_rate, :shipping_tax2_rate, :source, :start_date, :status,
      :sub_total, :sync_partners_teams, :sync_sales_teams, :tax2_total, :tax_rate, :tax_total, :three_d_status_code, :time_disc_amount, :time_disc_print,
      :time_disc_rate, :time_disc_tax1_amt, :time_disc_taxable, :time_tax_rate1, :time_tax_rate2, :to_be_emailed, :to_be_printed, :to_be_faxed, :total,
      :total_cost_estimate, :tracking_numbers, :tran_date, :tran_id, :tan_is_vsoe_bundle, :undep_funds, :valid_from, :vat_reg_num, :vsoe_auto_calc
    ].each do |field|
      expect(subject).to have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :bill_address_list, :billing_schedule, :created_from, :credit_card, :credit_card_processor, :currency, :custom_form,
      :department, :discount_item, :entity, :exp_cost_discount, :exp_cost_tax_code, :handling_tax_code, :item_cost_discount, :item_cost_tax_code,
      :job, :klass, :lead_source, :location, :message_sel, :opportunity, :partner, :payment_method, :posting_period, :promo_code, :rev_rec_schedule,
      :sales_group, :sales_rep, :ship_address_list, :ship_method, :shipping_tax_code, :subsidiary, :tax_item, :time_discount, :time_tax_code
    ].each do |record_ref|
      expect(subject).to have_record_ref(record_ref)
    end
  end
end
