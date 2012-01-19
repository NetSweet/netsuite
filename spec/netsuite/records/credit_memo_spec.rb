require 'spec_helper'

describe NetSuite::Records::CreditMemo do
  let(:memo) { NetSuite::Records::CreditMemo.new }

  it 'has all the right fields' do
    [
      :alt_handling_cost, :alt_shipping_cost, :amount_paid, :amount_remaining, :applied, :auto_apply, :balance, :bill_address,
      :contrib_pct, :created_date, :currency_name, :deferred_revenue, :discount_rate, :discount_total, :email, :est_gross_profit,
      :est_gross_profit_percent, :exchange_rate, :exclude_commission, :fax, :gift_cert_applied, :gift_cert_available,
      :gift_cert_total, :handling_cost, :handling_tax1_rate, :handling_tax2_rate, :is_taxable, :last_modified_date, :memo,
      :message, :on_credit_hold, :other_ref_num, :recognized_revenue, :rev_rec_on_rev_commitment, :sales_effective_date,
      :shipping_cost, :shipping_tax1_rate, :shipping_tax2_rate, :source, :status, :sub_total, :sync_partner_teams,
      :sync_sales_teams, :tax2_total, :tax_rate, :tax_total, :to_be_emailed, :to_be_faxed, :to_be_printed, :total,
      :total_cost_estimate, :tran_date, :tran_id, :tran_is_vsoe_bundle, :unapplied, :vat_reg_num, :vsoe_auto_calc
    ].each do |field|
      memo.should have_field(field)
    end
  end

  it 'has all the right record refs' do
    [
      :account, :bill_address_list, :created_from, :custom_form, :department, :discount_item, :entity, :gift_cert, :handling_tax_code, :job, :klass, :lead_source, :location, :message_sel, :partner, :posting_period, :promo_code, :sales_group, :sales_rep, :ship_method, :shipping_tax_code, :subsidiary, :tax_item
    ].each do |record_ref|
      memo.should have_record_ref(record_ref)
    end
  end

# <element name="transactionBillAddress" type="platformCommon:BillAddress" minOccurs="0"/>
# <element name="revenueStatus" type="platformCommonTyp:RevenueStatus" minOccurs="0"/>
# <element name="salesTeamList" type="tranCust:CreditMemoSalesTeamList" minOccurs="0"/>
# <element name="itemList" type="tranCust:CreditMemoItemList" minOccurs="0"/>
# <element name="partnersList" type="tranCust:CreditMemoPartnersList" minOccurs="0"/>
# <element name="applyList" type="tranCust:CreditMemoApplyList" minOccurs="0"/>
# <element name="customFieldList" type="platformCore:CustomFieldList" minOccurs="0"/>
end
