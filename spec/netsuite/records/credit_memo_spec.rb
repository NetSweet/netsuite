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

# <element name="customForm" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="entity" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="createdFrom" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="postingPeriod" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="department" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="class" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="location" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="subsidiary" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="job" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="salesRep" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="partner" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="leadSource" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="account" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="promoCode" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="discountItem" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="taxItem" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="messageSel" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="billAddressList" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="shipMethod" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="shippingTaxCode" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="handlingTaxCode" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="salesGroup" type="platformCore:RecordRef" minOccurs="0"/>
# <element name="giftCert" type="platformCore:RecordRef" minOccurs="0"/>


# <element name="transactionBillAddress" type="platformCommon:BillAddress" minOccurs="0"/>
# <element name="revenueStatus" type="platformCommonTyp:RevenueStatus" minOccurs="0"/>

# <element name="salesTeamList" type="tranCust:CreditMemoSalesTeamList" minOccurs="0"/>
# <element name="itemList" type="tranCust:CreditMemoItemList" minOccurs="0"/>
# <element name="partnersList" type="tranCust:CreditMemoPartnersList" minOccurs="0"/>
# <element name="applyList" type="tranCust:CreditMemoApplyList" minOccurs="0"/>
# <element name="customFieldList" type="platformCore:CustomFieldList" minOccurs="0"/>
end
